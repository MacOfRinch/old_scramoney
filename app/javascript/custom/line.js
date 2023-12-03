const element_w = document.getElementById('line-text').offsetWidth;
const line_width = element_w + 40 + 24 * 2 + 2
document.documentElement.style.setProperty('--line-width', `${line_width}px`);