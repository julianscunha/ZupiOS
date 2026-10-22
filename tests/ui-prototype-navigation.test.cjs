const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

const html = fs.readFileSync('prototypes/tv-ui/index.html', 'utf8');
const start = html.indexOf('function findDirectionalIndex(');
const end = html.indexOf('\n', start);
const match = start >= 0 ? [html.slice(start, end).trim()] : null;
assert.ok(match, 'prototype must define the spatial navigation helper');
const findDirectionalIndex = vm.runInNewContext(`(${match[0]})`);
const button = (x, y, width = 100, height = 60) => ({
  getBoundingClientRect: () => ({left:x, top:y, right:x+width, bottom:y+height, width, height})
});
const grid = [button(0,0), button(120,0), button(0,80), button(120,80)];

test('right and left follow the nearest horizontal neighbor', () => {
  assert.equal(findDirectionalIndex(grid, 0, 'right'), 1);
  assert.equal(findDirectionalIndex(grid, 1, 'left'), 0);
});
test('down and up follow the nearest vertical neighbor, not DOM order', () => {
  assert.equal(findDirectionalIndex(grid, 0, 'down'), 2);
  assert.equal(findDirectionalIndex(grid, 3, 'up'), 1);
});
test('does not move focus when no element exists in that direction', () => {
  assert.equal(findDirectionalIndex(grid, 0, 'left'), 0);
  assert.equal(findDirectionalIndex(grid, 3, 'right'), 3);
});
test('prefers alignment over a much closer diagonal candidate', () => {
  const elements = [button(0,0), button(80,40), button(0,100)];
  assert.equal(findDirectionalIndex(elements, 0, 'down'), 2);
});



test('inline SVG icons render valid markup without escaped quote artifacts', () => {
  const iconStart = html.indexOf('const iconPaths=');
  const iconEnd = html.indexOf("document.querySelector('#premium-band')", iconStart);
  assert.ok(iconStart >= 0 && iconEnd > iconStart, 'inline icon map must exist');
  const renderIcon = vm.runInNewContext(`(()=>{${html.slice(iconStart, iconEnd)};return icon('tv')})()`);
  assert.match(renderIcon, /^<svg class="glyph-icon" viewBox="0 0 24 24"/);
  assert.doesNotMatch(renderIcon, /\\\\"/);
});

test('version is current in footer, never in header, and assets remain local', () => {
  const header = html.split('</header>')[0];
  const footer = html.split('<footer>')[1].split('</footer>')[0];
  assert.doesNotMatch(header, /id="version"/);
  assert.match(footer, /id="version"/);
  assert.match(html, /const APP_VERSION='0\.7\.0-prototype'/);
  assert.doesNotMatch(html, /<(?:script|link)[^>]+(?:https?:)?\/\//i);
  assert.match(html, /prefers-reduced-motion:reduce/);
  assert.match(html, /max-height:650px/);
});


test('priority screen flows and remote-control recovery remain represented', () => {
  for (const screen of ['home', 'tv', 'profiles', 'settings', 'apps', 'media', 'opening', 'recovery', 'about']) {
    assert.match(html, new RegExp(`screen===['"]${screen}['"]`), `screen ${screen} must remain implemented`);
  }
  for (const action of ['tv', 'apps', 'media', 'settings', 'recovery', 'open-demo', 'retry', 'unavailable', 'network', 'check-network', 'reset-ui']) {
    assert.match(html, new RegExp(`case['"]${action}['"]`), `action ${action} must remain wired`);
  }
  assert.match(html, /e\.key==='Escape'\|\|e\.key==='Backspace'/, 'Back/Esc must remain available');
  assert.match(html, /e\.key==='h'\|\|e\.key==='H'\|\|e\.key==='Home'/, 'global Home shortcut must remain available');
  assert.match(html, /focusSelected\(\)/, 'rendered screen must restore focus to a selectable control');
});

test('remote directional navigation includes the header profile control', () => {
  assert.match(html, /const nav=\[document\.querySelector\('#profile-button'\),\.\.\.a\]/, 'directional navigation must include the profile button outside #app');
});

test('prototype exposes explicit simulated offline and failed-opening states', () => {
  assert.match(html, /Modo sem rede simulado/);
  assert.match(html, /A aplicação de demonstração não está instalada/);
  assert.match(html, /recursos locais permanecem acessíveis/);
  assert.match(html, /nenhuma operação de firmware ou reparo é executada/);
});
