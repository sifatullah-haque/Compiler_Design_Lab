# Lexical Analyzer using Flex

A lexical analyzer (tokenizer) built using Flex that identifies and categorizes different types of tokens in source code files.

## 📋 Overview

This project implements a lexical analyzer that scans input text files and identifies various token types including integers, floating-point numbers, keywords, identifiers, operators, and symbols. The analyzer provides detailed output showing each token found and generates a summary report with token counts.

## ✨ Features

- **Token Recognition**: Identifies multiple token types:
  - Integers (e.g., `123`, `42`)
  - Floating-point numbers (e.g., `3.14`, `2.5`)
  - Keywords (`if`, `else`, `while`, `for`, `int`, `float`, `main`)
  - Identifiers (variable and function names)
  - Operators (`+`, `-`, `*`, `/`, `%`, `=`)
  - Other symbols (parentheses, brackets, semicolons, etc.)

- **Detailed Output**: Displays each token with its type as it's recognized
- **Summary Statistics**: Provides a comprehensive count of all token types
- **File Input**: Reads from an input file (`input.txt`)

## 🛠️ Prerequisites

To compile and run this lexical analyzer, you need:

- **Flex** (Fast Lexical Analyzer Generator)
- **GCC** (GNU Compiler Collection) or any C compiler
- **Make** (optional, for build automation)

### Installation

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install flex gcc make
```

**macOS:**
```bash
brew install flex gcc
```

**Windows:**
- Install MinGW or Cygwin with flex package
- Or use WSL (Windows Subsystem for Linux)

## 📁 Project Structure

```
lexical-analyzer/
│
├── lexer.l          # Flex specification file (source code)
├── input.txt        # Input file to be analyzed
├── README.md        # Project documentation
└── Makefile         # Build automation (optional)
```

## 🚀 Usage

### 1. Compilation

**Using Flex and GCC directly:**
```bash
# Generate C code from Flex specification
flex lexer.l

# Compile the generated C code
gcc lex.yy.c -o lexer -lfl

# Or in one line:
flex lexer.l && gcc lex.yy.c -o lexer -lfl
```

**Using Makefile:**
Create a `Makefile` with the following content:
```makefile
CC = gcc
FLEX = flex
TARGET = lexer
SOURCE = lexer.l

$(TARGET): lex.yy.c
	$(CC) lex.yy.c -o $(TARGET) -lfl

lex.yy.c: $(SOURCE)
	$(FLEX) $(SOURCE)

clean:
	rm -f lex.yy.c $(TARGET)

run: $(TARGET)
	./$(TARGET)

.PHONY: clean run
```

Then compile using:
```bash
make
```

### 2. Running the Analyzer

1. Create an input file named `input.txt` in the same directory:
```c
int main() {
    int x = 10;
    float y = 3.14;
    if (x > 5) {
        x = x + 1;
    }
}
```

2. Run the lexical analyzer:
```bash
./lexer
```

### 3. Sample Output

```
KEYWORD: int
IDENTIFIER: main
SYMBOL: (
SYMBOL: )
SYMBOL: {
KEYWORD: int
IDENTIFIER: x
OPERATOR: =
INTEGER: 10
SYMBOL: ;
KEYWORD: float
IDENTIFIER: y
OPERATOR: =
FLOAT: 3.14
SYMBOL: ;
KEYWORD: if
SYMBOL: (
IDENTIFIER: x
SYMBOL: >
INTEGER: 5
SYMBOL: )
SYMBOL: {
IDENTIFIER: x
OPERATOR: =
IDENTIFIER: x
OPERATOR: +
INTEGER: 1
SYMBOL: ;
SYMBOL: }
SYMBOL: }

======= TOKEN SUMMARY =======
Total tokens   : 28
Integers       : 3
Floats         : 1
Keywords       : 4
Identifiers    : 5
Operators      : 4
Other Symbol  : 11
=============================
```

## 📝 How It Works

### Lexical Rules

The analyzer uses regular expressions to match different token patterns:

| Token Type | Pattern | Examples |
|------------|---------|----------|
| Float | `[0-9]+\.[0-9]+` | `3.14`, `2.0` |
| Integer | `[0-9]+` | `42`, `100` |
| Keywords | `(if\|else\|while\|for\|int\|float\|main)` | `if`, `while`, `int` |
| Identifiers | `[a-zA-Z_][a-zA-Z0-9_]*` | `variable`, `_count`, `myVar2` |
| Operators | `[+\-*/%=]` | `+`, `-`, `*`, `/` |
| Whitespace | `[ \t\r\n]+` | (ignored) |
| Symbols | `.` | `(`, `)`, `{`, `}`, `;` |

### Program Flow

1. **Initialization**: Opens `input.txt` for reading
2. **Tokenization**: `yylex()` scans the input character by character
3. **Pattern Matching**: Matches input against defined patterns
4. **Token Processing**: For each match:
   - Increments appropriate counter
   - Prints token type and value
5. **Summary**: Displays final token statistics

## 🔧 Customization

### Adding New Keywords

To add new keywords, modify the keyword pattern in `lexer.l`:
```c
(if|else|while|for|int|float|main|return|void|char)  { keyword_count++; ... }
```

### Adding New Operators

To recognize additional operators, update the operator pattern:
```c
[+\-*/%=<>!&|]  { operator_count++; ... }
```

### Changing Input File

To use a different input file, modify the filename in `main()`:
```c
yyin = fopen("your_file.txt", "r");
```

## 🐛 Troubleshooting

### Common Issues

1. **"Cannot open input.txt"**
   - Ensure `input.txt` exists in the same directory as the executable
   - Check file permissions

2. **Compilation error: "undefined reference to yywrap"**
   - Add `-lfl` flag when compiling: `gcc lex.yy.c -o lexer -lfl`
   - Or define `yywrap()` in the code (already included)

3. **Flex not found**
   - Install Flex using your package manager
   - Check if `flex` is in your PATH: `which flex`

## 📊 Token Statistics Explained

- **Total tokens**: Overall count of all recognized tokens
- **Integers**: Whole numbers without decimal points
- **Floats**: Numbers with decimal points
- **Keywords**: Reserved programming language words
- **Identifiers**: Variable names, function names
- **Operators**: Mathematical and assignment operators
- **Other Symbols**: Brackets, parentheses, semicolons, etc.

