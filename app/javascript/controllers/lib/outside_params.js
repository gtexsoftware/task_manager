export const attachOutsideParams = function(safeList, target) {
  const params = new URLSearchParams(window.location.search)

  deleteAllOutsideParams(target)

  params.forEach((value, key) => {
    if (!safeList.includes(key)) {
      createOutsideParamInput(target, key, value)
    }
  })
}

const createOutsideParamInput = function(target, key, value) {
  const alreadyCreatedInput = target.querySelector(`input[name="${key}"]`)

  if (alreadyCreatedInput) return

  var input = document.createElement('input');

  input.setAttribute('name', key);
  input.setAttribute('value', value);
  input.setAttribute('type', 'hidden');
  input.classList.add('outside-param')

  target.appendChild(input)
}

const deleteAllOutsideParams = function(target) {
  target.querySelectorAll('.outside-param').forEach(element => element.remove())
}