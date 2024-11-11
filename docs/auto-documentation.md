# GitHub Pages Documentation Deployment Workflow

## Overview

This GitHub Actions workflow automates the process of converting Markdown documentation files to HTML and deploying them to GitHub Pages.

## Workflow Triggers

- Automatically on push to `main` branch when files in `docs/**/*.md` are modified
- Manually via workflow dispatch

## Permissions

```yaml
permissions:
  contents: write  # For committing changes
  pages: write     # For GitHub Pages deployment
  id-token: write  # For authentication
```

## Workflow Steps

### 1. Environment Setup

```yaml
- uses: actions/checkout@v4
- uses: actions/configure-pages@v5
```

- Checks out repository code
- Configures GitHub Pages environment

### 2. Documentation Processing

```yaml
- name: Install Pandoc
  # Installs Pandoc for Markdown to HTML conversion

- name: Convert MD to HTML
  # Converts all .md files to .html
  # Excludes README.md and .github directory
```

### 3. HTML Generation

```yaml
- name: Generate index.html
  # Creates an index page with:
  - Documentation title
  - Styled layout
  - Links to all converted documentation
```

### 4. Deployment

```yaml
- uses: actions/upload-pages-artifact@v3
  with:
    path: 'docs/'
- uses: actions/deploy-pages@v4
```

## Features

- Automatic Markdown to HTML conversion using Pandoc
- Generates styled index page
- Maintains documentation hierarchy
- Concurrent deployment protection
- Automatic git commits for generated files

## Requirements

- Repository must have GitHub Pages enabled
- Documentation files must be in docs directory
- Files must use `.md` extension

## Output

- Converted HTML files in docs directory
- Index page listing all documentation
- Deployed to GitHub Pages URL
- Commit with converted files in repository

## Environment

- Runs on: `ubuntu-latest`
- Environment: `github-pages`
- URL available in: `steps.deployment.outputs.page_url`

## Notes

- Skips conversion of `README.md`
- Skips files in .github directory
- Uses sans-serif font and responsive layout
- Maximum width of 800px for readability