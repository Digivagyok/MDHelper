# Markdown Helper Script

Markdown Helper is a Lua-based script designed to simplify the process of generating Markdown content with various formatting options. It supports headers, lists, tables, code blocks, and more, making it a versatile tool for Markdown enthusiasts.

---

## Prerequisites

Before setting up the Markdown Helper, ensure the following prerequisites are met:

1. **Lua Installed**:
   - The script requires Lua to be installed on your machine.
   - You can download Lua from the [official Lua website](https://www.lua.org/download.html).
   - Verify the installation by running the following command in your terminal:
     ```bash
     lua -v
     ```
     This should display the Lua version installed on your system.

---

## Setup

Follow the steps below to set up the Markdown Helper script on your system:

### Windows

1. **Clone the Repository**:
   - Open a terminal and run:
     ```bash
     git clone https://github.com/Digivagyok/MDHelper.git
     ```

2. **Set Up a Function in PowerShell**:
   - Open your PowerShell profile by running:
     ```powershell
     notepad $PROFILE
     ```
   - If the file does not exist, PowerShell will create it for you.

   - Add the following function to your profile:
     ```powershell
     function mdhelper {
         lua "C:\Downloaded\Path\MDHelper.lua" @args
     }
     ```
   - Save the file and close Notepad.

3. **Reload Your PowerShell Profile**:
   - Run the following command to apply the changes:
     ```powershell
     . $PROFILE
     ```

4. **Verify the Setup**:
   - Open a terminal and run:
     ```bash
     mdhelper --help
     ```
   - This should display the help screen for the Markdown Helper script.

### macOS/Linux

1. **Clone the Repository**:
   - Open a terminal and run:
     ```bash
     git clone https://github.com/Digivagyok/MDHelper.git
     ```

2. **Add the Script to Environment Variables**:
   - Copy the full path of the [MDHelper.lua](http://_vscodecontentref_/3) file (e.g., `/path/to/MDHelper/MDHelper.lua`).
   - Open your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`) in a text editor:
     ```bash
     nano ~/.bashrc
     ```
   - Add the following line:
     ```bash
     alias mdhelper='lua /path/to/MDHelper/MDHelper.lua'
     ```
   - Save the file and reload the shell configuration:
     ```bash
     source ~/.bashrc
     ```

3. **Verify the Setup**:
   - Open a terminal and run:
     ```bash
     mdhelper --help
     ```
   - This should display the help screen for the Markdown Helper script.

---

## Usage

Once the setup is complete, you can use the `mdhelper` command to generate Markdown content. For example:

- `h`: Insert a header (e.g., `# Header`).
- `ch`: Insert checkboxes (checked: true/false).
- `ol`: Insert an ordered list with optional depth.
- `ul`: Insert an unordered list with optional depth.
- `bq`: Insert block quotes with optional depth.
- `img`: Insert an image with source and alt text.
- `link`: Insert a hyperlink with source and alt text.
- `tb`: Insert a table with the specified rows, columns, and optional headers.
- `mark`: Highlight text using `<mark>` tags.
- `x`: Cross out text using `~~strikethrough~~`.
- `sup`: Insert superscript text.
- `sub`: Insert subscript text.
- `bold`: Insert bold text (`**bold**`).
- `italic`: Insert italic text (`*italic*`).
- `bolditalic`: Insert bold and italic text (`***bolditalic***`).
- `c`: Insert inline code (`` `code` ``).
- `mc`: Insert a multiline code block from a file with optional line range and language.

## Features

- Easily generate Markdown content with various formatting options.
- Supports headers, lists (ordered and unordered), tables, and block quotes.
- Insert inline and multiline code blocks with syntax highlighting.
- Add images, hyperlinks, and formatted text (bold, italic, strikethrough, etc.).
- Highlight text, insert superscript and subscript, and create checkboxes.
- Simple command-line interface for quick and efficient Markdown generation.

---

## Contributing

Contributions are welcome! If you have ideas for new features, bug fixes, or improvements, feel free to submit an issue or a pull request on the [GitHub repository](https://github.com/Digivagyok/MDHelper).

To contribute:
1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Commit your changes and push them to your fork.
4. Submit a pull request with a detailed description of your changes.

---

## License

This project is licensed under the MIT License. You are free to use, modify, and distribute this software. See the `LICENSE` file for more details.