// component-event@0.1.4 downloaded from https://ga.jspm.io/npm:component-event@0.1.4/index.js

var n={};var e=window.addEventListener?"addEventListener":"attachEvent",t=window.removeEventListener?"removeEventListener":"detachEvent",d="addEventListener"!==e?"on":"";n.bind=function(n,t,i,r){n[e](d+t,i,r||false);return i};n.unbind=function(n,e,i,r){n[t](d+e,i,r||false);return i};const i=n.bind,r=n.unbind;export default n;export{i as bind,r as unbind};

