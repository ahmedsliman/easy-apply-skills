#!/usr/bin/env node
// Install job-skills (Agent Skills standard) into AI coding tools.
// Same flags as install.sh; works on Windows, macOS, and Linux.
'use strict'

const { cpSync, mkdirSync, readdirSync } = require('node:fs')
const { homedir } = require('node:os')
const { join } = require('node:path')
const { parseArgs } = require('node:util')

const root = join(__dirname, '..')
const skillsSrc = join(root, 'skills')
const commandsSrc = join(root, 'opencode-commands')

const usage = `Usage:
  npx github:ahmedsliman/easy-apply-skills   # all global targets (Claude Code, Codex, OpenCode)
  --claude            # ~/.claude/skills
  --codex             # ~/.codex/skills
  --opencode          # ~/.config/opencode/skills
  --opencode-commands # ~/.config/opencode/commands (/job-coverletter, /job-match)
  --cursor-dir=DIR    # DIR/.agents/skills (Cursor project skills)`

let values
try {
  ;({ values } = parseArgs({
    options: {
      claude: { type: 'boolean' },
      codex: { type: 'boolean' },
      opencode: { type: 'boolean' },
      'opencode-commands': { type: 'boolean' },
      'cursor-dir': { type: 'string' },
      help: { type: 'boolean', short: 'h' },
    },
  }))
} catch (err) {
  console.error(err.message)
  console.error(usage)
  process.exit(1)
}

if (values.help) {
  console.log(usage)
  process.exit(0)
}

const home = homedir()
const skillDests = []

if (values.claude) skillDests.push(join(home, '.claude', 'skills'))
if (values.codex) skillDests.push(join(home, '.codex', 'skills'))
if (values.opencode) skillDests.push(join(home, '.config', 'opencode', 'skills'))
if (values['cursor-dir']) skillDests.push(join(values['cursor-dir'], '.agents', 'skills'))

// No target flags: install all global targets.
if (skillDests.length === 0 && !values['opencode-commands']) {
  skillDests.push(
    join(home, '.claude', 'skills'),
    join(home, '.codex', 'skills'),
    join(home, '.config', 'opencode', 'skills'),
  )
}

for (const dest of skillDests) {
  mkdirSync(dest, { recursive: true })
  for (const entry of readdirSync(skillsSrc)) {
    cpSync(join(skillsSrc, entry), join(dest, entry), { recursive: true })
  }
  console.log(`skills -> ${dest}`)
}

if (values['opencode-commands']) {
  const dest = join(home, '.config', 'opencode', 'commands')
  mkdirSync(dest, { recursive: true })
  for (const file of readdirSync(commandsSrc)) {
    if (file.endsWith('.md')) cpSync(join(commandsSrc, file), join(dest, file))
  }
  console.log(`commands -> ${dest}`)
}

console.log('done.')
