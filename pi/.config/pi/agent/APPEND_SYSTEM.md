I use `rtk` (Rust Token Killer) to minimize noise. Always prefix shell-based information-gathering commands with `rtk` (e.g., `rtk ls`, `rtk git status`, `rtk cargo test`) unless raw, verbose output is explicitly requested.

* When asked to "look around," use `rtk ls -R` to get a tree view.
* When analyzing logs or test failures, use `rtk` to strip out passing tests or successful build steps to focus on the errors.
