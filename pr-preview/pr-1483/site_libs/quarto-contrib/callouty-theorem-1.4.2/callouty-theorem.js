// Shows the element's number in a callout header as plain text with a "§" anchor beside it.
//
// The header of a numbered element's callout holds a cross-reference to the
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

  // The element behind an href that points into this page, or null.
  function targetOf(link) {
    var url;
    try {
      url = new URL(link.getAttribute("href"), location.href);
      if (url.origin + url.pathname !== location.origin + location.pathname || !url.hash) {
        return null;
      }
      return document.getElementById(decodeURIComponent(url.hash.slice(1)));
    } catch (e) {
      return null;
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    // Only the element's own label: the first link in the title whose target is the
    // callout itself or the div that opens its body. A cross-reference in the element's name, as in
    // "Solution to Exercise 1", points at another callout and stays a link, and an
    // unnumbered element has no label link at all.
    var seen = new Set();
    document.querySelectorAll(LABEL).forEach(function (link) {
      var container = link.closest(".callout-title-container");
      var callout = container && container.closest(".callout");
      var target = targetOf(link);
      if (!callout || !target || seen.has(container)) { return; }
      // The callout itself, or the div that opens its own body: a target deeper in the
      // body ("Proof (see @lem-inner)") or in a nested callout is another element.
      var body = callout.querySelector(".callout-body-container");
      var own = target === callout || (body && target === body.firstElementChild);
      if (!own) { return; }
      seen.add(container);
      var text = link.textContent.trim();
      var kind = text.split(/[\s\u00a0]/)[0].toLowerCase();
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
      if (!instance || !instance.props.onTrigger) {
        return;
      }
      // On a served site Quarto's navigation script has already made the href
      // absolute, so compare the resolved URL, not a leading "#".
      var target = targetOf(link);
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

  // The popup is appended to the body, out of the link's tab order, so Tab from
  // the link moves into the popup while it is open.
  document.addEventListener("keydown", function (event) {
    if (event.key !== "Tab" || event.shiftKey) { return; }
    var link = document.activeElement;
    var instance = link && link._tippy;
    if (!instance || !instance.state.isVisible) { return; }
    var first = instance.popper.querySelector("a[href], button");
    if (first) {
      event.preventDefault();
      first.focus();
    }
  });

  // Quarto creates the previews in an inline script at the end of the page.
  window.addEventListener("load", patchPreviews);
})();
