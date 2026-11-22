// Makes the cross-reference link in a folding callout's header follow its link.
//
// With `title-ref: true` the header of a collapsible callout holds a link to the
// element's own id ("Example 1").
// The header carries Bootstrap's data-bs-toggle="collapse", and Bootstrap's click
// handler calls preventDefault on a click that lands on a link inside the toggle,
// so the click only folded the callout and readers could not get the element's URL.
// Bootstrap listens in the capture phase on document.
// This listener runs in the capture phase on window, which runs first, and stops the
// click there, so the browser follows the link and the address bar gains the #id.
// The rest of the header, and the chevron, still toggle the fold.
(function () {
  "use strict";

  var LABEL = ".callout-header .callout-title-container a.quarto-xref";

  window.addEventListener("click", function (event) {
    var target = event.target;
    if (target && target.closest && target.closest(LABEL)) {
      event.stopPropagation();
    }
  }, true);

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(LABEL).forEach(function (link) {
      var kind = link.textContent.trim().split(/[\s ]/)[0].toLowerCase();
      link.setAttribute("title", "Link to this " + kind);
    });
  });
})();
