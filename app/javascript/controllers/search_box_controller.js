import { Controller } from "@hotwired/stimulus"
import { debounce } from "./lib/debounce"
import { attachOutsideParams } from "./lib/outside_params";


const SUBMIT_DEBOUNCE_TIME = 300
const MINIMUM_CHARACTERS_TO_SUBMIT = 3
const DOWN_KEY_CODE = 40
const UP_KEY_CODE = 38

export default class extends Controller {
  static targets = ['input', 'form', 'results']
  static values = { domain: String, enterBehavior: Boolean }

  initialize() {
    this.submit = debounce(this.submit.bind(this), SUBMIT_DEBOUNCE_TIME)

    this.formTarget.addEventListener('input', this.updateSearchQueryTerm.bind(this))
  }

  connect() {
    console.log(' foi')
  }

  submit() {
    if (!this.inputHasValue()) return this.hideResults()
    if (!this.hasMinimumCharactersToSubmit()) return

    if (this.enterBehaviorValue) {
      const authenticityTokenInput = this.formTarget.querySelector('input[name="authenticity_token"]')

      this.formTarget.dataset.turboFrame = this.domainValue
      this.formTarget.method = 'post'
      this.formTarget.action = `/${this.domainValue}/autocomplete_search`
      this.formTarget.dataset.turboAction = ''

      if (authenticityTokenInput) {
        this.formTarget.querySelector('input[name="authenticity_token"]').disabled = false
      }
    }

    this.formTarget.requestSubmit()
  }

  hasMinimumCharactersToSubmit() {
    return this.inputTarget.value.length >= MINIMUM_CHARACTERS_TO_SUBMIT
  }

  inputHasValue() {
    return Boolean(this.inputTarget.value)
  }

  hideResults() {
    if (this.hasResultsTarget) this.resultsTarget.remove()
  }

  showResultsContainer() {
    this.element.querySelector('.search-results').style.display = 'block'
  }

  hideResultsContainer() {
    this.element.querySelector('.search-results').style.display = 'none'
  }

  escapeAction() {
    const isInputFocused = document.activeElement === this.inputTarget

    if (!isInputFocused && this.hasResultsTarget) {
      this.inputTarget.focus()
      this.hideResults()
    } else {
      this.inputTarget.blur()
      this.hideResults()
    }
  }

  startKeyNavigation(e) {
    const isDownKey = e.keyCode == DOWN_KEY_CODE

    if (isDownKey) {
      const firstOption = this.resultsTarget.querySelector('li:first-child > .search-box-trigger')

      firstOption.focus()
      e.preventDefault()
    }
  }

  keyNavigation(e) {
    if (!this.hasResultsTarget) return

    const isUpKey = e.keyCode == UP_KEY_CODE
    const isDownKey = e.keyCode == DOWN_KEY_CODE
    const listOfOptions = Array.from(this.resultsTarget.children)
    let keyIndex = this.indexOfOption(e.target, listOfOptions)
    let option

    if (isUpKey) {
      if (keyIndex == 0) {
        const end = this.inputTarget.value.length;

        return setTimeout(() => {
          this.inputTarget.setSelectionRange(end, end)
          this.inputTarget.focus()
        }, 0)
      }

      keyIndex--
    }

    if (isDownKey) {
      const nextIndex = keyIndex + 1
      if (nextIndex === listOfOptions.length) return
      keyIndex = nextIndex
    }

    option = this.resultsTarget.querySelector(`li:nth-child(${keyIndex + 1}) > .search-box-trigger`)
    option.focus()
  }

  indexOfOption(option, list) {
    return list.indexOf(option.parentElement)
  }

  handleEnterSubmit(e) {
    this.avoidMultipleSubmitsByEnter(e)

    if (this.enterBehaviorValue) {
      this.updateTable()
    }
  }

  avoidMultipleSubmitsByEnter(e) {
    let lastQuery = this.formTarget.dataset.lastQuery
    if (lastQuery == this.inputTarget.value) return e.preventDefault()

    this.formTarget.dataset.lastQuery = this.inputTarget.value
  }

  updateTable() {
    attachOutsideParams(['search_box_query', 'page'], this.formTarget)

    this.formTarget.dataset.turboFrame = `${this.domainValue}_table`
    this.formTarget.method = 'get'
    this.formTarget.action = location.pathname
    this.formTarget.dataset.turboAction = 'advance'
    this.formTarget.querySelector('input[name="authenticity_token"]').disabled = true

    this.hideResults()
  }

  handleAllResultsAction() {
    this.updateTable()

    this.formTarget.requestSubmit()
  }

  updateSearchQueryTerm() {
    if (this.enterBehaviorValue) {
      const searchQueryTerm = this.element.querySelector('.search-query-term')

      if (searchQueryTerm) {
        searchQueryTerm.textContent = this.inputTarget.value
      }
    }
  }
}