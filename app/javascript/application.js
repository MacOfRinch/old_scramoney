// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets
const Popper = require('popper.js');
window.Popper = Popper;
import "bootstrap"
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { library } from "@fortawesome/fontawesome-svg-core"
import '@fortawesome/fontawesome-free'
library.add(fas, far, fab)
import "@hotwired/turbo-rails"
import './custom/line';
import "chartkick"
import "Chart.bundle"