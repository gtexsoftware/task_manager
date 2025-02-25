import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['taskCategory']
  static values = {
    translations: String
  }

  handleCategoryChange(e) {
    if (document.getElementsByClassName('error').length > 0) {
      const category = e.target.value
      const turboFrame = document.querySelector(`turbo-frame#purpose_custom_category`)
      const url = new URL(window.location.href)
      url.pathname = "/tasks/new"
      url.searchParams.set('category', category)
      turboFrame.src = url
    } else {

    const category = e.target.value
    const turboFrame = document.querySelector(`turbo-frame#purpose_custom_category`)

    const url = new URL(window.location.href)
    url.searchParams.set('category', category)

    turboFrame.src = url
    }
  }

  handleSelectUser(e) {
    const {
      employeeId,
      employeeName
    } = e.target.closest('button').dataset

    this.hideResults('employees')
    this.updateSearchBoxWithOrgUserName(employeeName)
    this.updateOrgUserIdHiddenField(employeeId)
  }

  hideResults(domain) {
    const results = this.element.querySelector(`#${domain} ul`)
    results.style.display = 'none'
  }

  updateSearchBoxWithOrgUserName(employeeName) {
    const searchBoxInput = this.element.querySelector('#search_box_input')
    searchBoxInput.value = employeeName
  }

  updateOrgUserIdHiddenField(employeeId) {
    const employeeIdHiddenField = document.querySelector('#task_employee_id')
    employeeIdHiddenField.value = employeeId
  }

  showTask(e) {
    const deleteModal = document.getElementsByClassName('dialog-header')[0].firstElementChild.innerText
    this.translations = JSON.parse(this.translationsValue);
    if (e.target.nodeName == 'A' || e.target.nodeName == 'BUTTON' ||  e.target.nodeName == 'DIV' || deleteModal === this.translations.delete)  return

    fetch(`/tasks/${e.currentTarget.dataset.taskId}`, {
      method: 'GET',
      headers: {
        'Turbo-Frame': 'show_task'
      }
    })
    .then(response => response.text())
    .then(html => {
      document.getElementById('show_task').innerHTML = html;
    });
  }
}