I use `rtk` (Rust Token Killer) to minimize noise. Always prefix shell-based information-gathering commands with `rtk` (e.g., `rtk ls`, `rtk git status`, `rtk cargo test`) unless raw, verbose output is explicitly requested.

### When to Use `rtk`

* **Directory & File Exploration:**
  * When asked to "look around," use `rtk ls -R` or `rtk find` to get a token-optimized tree view of directories.
  * To inspect files, use `rtk read <path>` to smart-filter boilerplate or `rtk read <path> -l aggressive` to view signatures only.
  * For finding text patterns, use `rtk grep <pattern>` or `rtk rg <pattern>` to get grouped, truncated search results grouped by file.
  * To compare files or check changes, use `rtk diff <file1> <file2>` or `rtk git diff` for an ultra-condensed diff showing only changed lines.

* **Git Operations:**
  * Use `rtk git status` for a compact status, `rtk git log -n 10` for one-line commits, and `rtk git diff` for condensed diffs.
  * For committing and pushing, `rtk git add`, `rtk git commit`, and `rtk git push` will return compact "ok" statuses to save tokens.

* **Analyzing Logs or Test Failures:**
  * Use `rtk test <cmd>` or specific runners like `rtk cargo test`, `rtk jest`, `rtk vitest`, `rtk pytest`, `rtk go test`, or `rtk rspec` to run test suites. RTK strips out passing tests and successful build steps to focus purely on errors/failures.
  * Use `rtk err <cmd>` to run any command and filter/show *only* its errors and warnings.
  * For inspecting log files or container logs, use `rtk log <file>` or `rtk docker logs <container>` to filter and deduplicate repeating log lines with counts.

* **Build & Lint Verification:**
  * Use `rtk cargo build`, `rtk cargo clippy`, `rtk tsc`, `rtk lint`, or `rtk ruff check` to get highly condensed build and linter diagnostic outputs grouped by file.

* **Data & Packages:**
  * Use `rtk json <file>` (with `--keys-only` if you only need the structure) to read large JSON files without flooding context with values.
  * Use `rtk deps` or `rtk pnpm list`/`rtk pip list` for token-efficient dependency trees and packages.
  * Use `rtk env` to see environment variables filtered and with sensitive values masked.

* **Failed Commands & Full Output Recovery:**
  * If a command fails and you absolutely need the full unfiltered output, do not re-run it raw. RTK automatically saves raw outputs to `~/.local/share/rtk/tee/` (as indicated by the `[full output: ...]` log suffix). Use standard `read` on that file.

