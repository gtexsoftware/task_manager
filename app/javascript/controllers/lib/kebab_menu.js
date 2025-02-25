function kebab_menu() {
  document.body.addEventListener('click', function(event){
    var opened_kebab = document.querySelectorAll('input[type=checkbox]:checked');

    for(let i = 0; i < opened_kebab.length; i++) {
      if(opened_kebab[i].closest('.kebab_menu') != event.target.closest('.kebab_menu')) {
        opened_kebab[i].checked = false;
      }
    }
  });
}

export default kebab_menu()