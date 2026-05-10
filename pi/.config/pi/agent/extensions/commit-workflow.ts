import { spawnSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import * as os from "node:os";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { complete } from "@mariozechner/pi-ai";

/**
 * Git Commit Workflow Extension
 * 
 * Adds a /commit command that:
 * 1. Generates a conventional commit message from staged changes.
 * 2. Opens the message in your external $EDITOR (e.g. Neovim).
 * 3. Commits the changes and returns to the pi prompt.
 */
export default function (pi: ExtensionAPI) {
  pi.registerCommand("commit", {
    description: "Generate commit message from staged changes and edit in Neovim",
    handler: async (_args, ctx) => {
      if (!ctx.hasUI) {
        ctx.ui.notify("The /commit command requires interactive mode.", "error");
        return;
      }

      if (!ctx.model) {
        ctx.ui.notify("No model selected to generate commit message.", "error");
        return;
      }

      // Check for staged changes
      const { stdout: diff } = await pi.exec("git", ["diff", "--staged"]);
      if (!diff.trim()) {
        ctx.ui.notify("No staged changes found to commit.", "warning");
        return;
      }

      // Get git status for comments
      const { stdout: status } = await pi.exec("git", ["status"]);

      // 1. Generate the suggested message
      ctx.ui.setStatus("commit", "Generating commit message...");
      
      try {
        const auth = await ctx.modelRegistry.getApiKeyAndHeaders(ctx.model);
        if (!auth.ok || !auth.apiKey) {
          ctx.ui.notify(`Could not get API key for ${ctx.model.id}`, "error");
          return;
        }

        const prompt = `Review the following staged changes and write a commit message following the Conventional Commits 1.0.0 specification.
Requirements:
- Choose the most appropriate type: feat, fix, refactor, perf, style, test, docs, build, ops, chore.
- The subject line must be imperative, present tense, lowercase at the start, no trailing period, and no more than 50 characters.
- Add a body if it helps explain context. Wrap lines at about 72 characters.
- Output ONLY the final commit message with no commentary or code fences.

Staged Changes:
${diff}`;

        const response = await complete(
          ctx.model,
          { messages: [{ role: "user", content: [{ type: "text", text: prompt }], timestamp: Date.now() }] },
          { apiKey: auth.apiKey, headers: auth.headers, signal: ctx.signal }
        );

        const generatedMsg = response.content
          .filter((c): c is { type: "text"; text: string } => c.type === "text")
          .map(c => c.text)
          .join("");

        // 2. Open in external editor using the TUI instance from ctx.ui.custom
        await ctx.ui.custom<void>(async (tui, _theme, _kb, done) => {
          const editorCmd = process.env.VISUAL || process.env.EDITOR || "nvim";
          const tmpFile = path.join(os.tmpdir(), `pi-commit-${Date.now()}.md`);
          
          const statusComments = status.trim().split('\n').map(line => `# ${line}`).join('\n');
          const fileContent = `${generatedMsg}\n\n# Please enter the commit message for your changes. Lines starting\n# with '#' will be ignored, and an empty message aborts the commit.\n#\n${statusComments}`;
          
          fs.writeFileSync(tmpFile, fileContent, "utf-8");

          try {
            // Suspend TUI and launch editor
            tui.stop();
            const [cmd, ...args] = editorCmd.split(" ");
            const result = spawnSync(cmd, [...args, tmpFile], { 
              stdio: "inherit", 
              shell: process.platform === "win32" 
            });
            tui.start();
            tui.requestRender(true); // Full redraw

            if (result.status === 0) {
              const content = fs.readFileSync(tmpFile, "utf-8");
              const finalMsg = content
                .split('\n')
                .filter(line => !line.trim().startsWith('#'))
                .join('\n')
                .trim();

              if (finalMsg) {
                // 3. Perform the commit
                const { code, stderr } = await pi.exec("git", ["commit", "-m", finalMsg]);
                if (code === 0) {
                  ctx.ui.notify("Successfully committed changes.", "success");
                } else {
                  ctx.ui.notify(`Commit failed: ${stderr}`, "error");
                }
              } else {
                ctx.ui.notify("Commit cancelled: empty message.", "warning");
              }
            } else {
              ctx.ui.notify("Editor exited with error. Commit cancelled.", "warning");
            }
          } catch (e) {
            tui.start();
            tui.requestRender(true);
            ctx.ui.notify(`Failed to launch editor: ${e}`, "error");
          } finally {
            if (fs.existsSync(tmpFile)) fs.unlinkSync(tmpFile);
            done();
          }

          return { render: () => [], invalidate: () => {} };
        });
      } catch (error) {
        ctx.ui.notify(`Error generating commit message: ${error instanceof Error ? error.message : String(error)}`, "error");
      } finally {
        ctx.ui.setStatus("commit", undefined);
      }
    }
  });
}
