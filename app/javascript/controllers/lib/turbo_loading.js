import { Turbo } from "@hotwired/turbo-rails";

addEventListener('turbo:before-fetch-request', function () {
  document.querySelector('body').classList.add('body-loading-state');
  Turbo.navigator.delegate.adapter.showProgressBar();
})

addEventListener('turbo:before-fetch-response', function () {
  document.querySelector('body').classList.remove('body-loading-state');
  Turbo.navigator.delegate.adapter.progressBar.hide();
})