// Shows the element's number in a callout header as plain text with a "§" anchor beside it.
//
// With `title-ref: true` the header of a callout holds a cross-reference to the
// element's own id ("Example 1"), which Quarto resolves to a link.
// A link in the header made the whole label a hyperlink, and the header's bold type
// reached its hover preview.
// This turns the label into plain text and adds a small "§" link to the id after it,
// as the div-anchors extension does in the body.
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
  var ANCHOR = ".callout-header .callout-title-container a.callouty-anchor";

  window.addEventListener("click", function (event) {
    var target = event.target;
    if (target && target.closest && target.closest(ANCHOR)) {
      event.stopPropagation();
    }
  }, true);

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(LABEL).forEach(function (link) {
      var text = link.textContent.trim();
      var kind = text.split(/[\s ]/)[0].toLowerCase();
      var label = document.createElement("span");
      label.className = "callouty-label";
      label.textContent = text;
      var anchor = document.createElement("a");
      anchor.className = "callouty-anchor";
      anchor.setAttribute("href", link.getAttribute("href"));
      anchor.setAttribute("title", "Link to this " + kind);
      anchor.setAttribute("aria-label", "Link to this " + kind);
      anchor.textContent = "§";
      link.replaceWith(label, anchor);
    });
  });

  // Hover preview of a cross-reference whose target sits inside a callout.
  //
  // Quarto's preview copies the target's innerHTML, and a numbered theorem, example or
  // solution is a div inside the callout, so the preview showed bare content without the
  // callout's header, colour and bar.
  // Quarto also appends the preview to the link's parent, so a link in a callout header
  // passed the header's bold type on to the whole preview.
  // For such links this swaps the preview content for an open copy of the whole callout
  // and appends the preview to the body.
  function openCopy(callout) {
    var copy = callout.cloneNode(true);
    copy.removeAttribute("id");
    copy.querySelectorAll("[id]").forEach(function (el) { el.removeAttribute("id"); });
    copy.querySelectorAll(".callout-collapse").forEach(function (el) { el.classList.add("show"); });
    copy.querySelectorAll("[data-bs-toggle], [data-bs-target]").forEach(function (el) {
      el.removeAttribute("data-bs-toggle");
      el.removeAttribute("data-bs-target");
    });
    copy.querySelectorAll(".callout-btn-toggle").forEach(function (el) { el.remove(); });
    var box = document.createElement("div");
    box.appendChild(copy);
    if (window.Quarto && window.Quarto.typesetMath) {
      window.Quarto.typesetMath(box);
    }
    return box.innerHTML;
  }

  function patchPreviews() {
    document.querySelectorAll("a.quarto-xref").forEach(function (link) {
      var instance = link._tippy;
      var href = link.getAttribute("href") || "";
      if (!instance || href.charAt(0) !== "#" || !instance.props.onTrigger) {
        return;
      }
      var target = document.getElementById(href.slice(1));
      var callout = target && target.closest(".callout");
      if (!callout) {
        return;
      }
      var quartoTrigger = instance.props.onTrigger;
      instance.setProps({
        appendTo: function () { return document.body; },
        onTrigger: function (inst, event) {
          quartoTrigger(inst, event);
          inst.setContent(openCopy(callout));
        }
      });
    });
  }

  // Quarto creates the previews in an inline script at the end of the page.
  window.addEventListener("load", patchPreviews);
})();
