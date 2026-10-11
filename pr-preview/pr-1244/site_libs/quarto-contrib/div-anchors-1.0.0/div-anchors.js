/**
 * div-anchors.js
 *
 * Adds visual URL anchor links to Quarto theorem and proof divs,
 * similarly to the `anchor-sections` option for HTML headings.
 *
 * After the DOM is ready, finds all theorem/proof divs that have an `id`
 * attribute and inserts an anchor link (§) right after the theorem-title
 * or proof-title span. The anchor is hidden by default and appears on hover,
 * controlled by div-anchors.css.
 */

(function () {
  "use strict";

  /**
   * CSS selector matching all Quarto theorem and proof div environments.
   *
   * Quarto adds the `.theorem` class to all theorem-type divs
   * (theorem, lemma, corollary, proposition, conjecture, definition,
   * example, exercise, algorithm), so `.theorem[id]` covers all of them.
   * Proof-type environments (.proof, .remark, .solution) are listed
   * separately because they do not carry the `.theorem` class.
   */
  var THEOREM_SELECTOR = [
    ".theorem[id]", /* covers: theorem, lemma, corollary, proposition,
                                conjecture, definition, example,
                                exercise, algorithm */
    ".proof[id]",
    ".remark[id]",
    ".solution[id]",
  ].join(", ");

  /**
   * Create a styled anchor element pointing to the given id.
   * @param {string} id - The target element's id attribute value.
   * @returns {HTMLAnchorElement}
   */
  function createAnchor(id) {
    var a = document.createElement("a");
    a.href = "#" + id;
    a.className = "div-anchor";
    a.setAttribute("aria-label", "Anchor");
    var icon = document.createElement("span");
    icon.setAttribute("aria-hidden", "true");
    icon.textContent = "\u00A7";
    a.appendChild(icon);
    return a;
  }

  /**
   * Add anchor links to all theorem/proof divs with ids on the page.
   */
  function addDivAnchors() {
    var divs = document.querySelectorAll(THEOREM_SELECTOR);
    divs.forEach(function (div) {
      var id = div.id;
      if (!id) {
        return;
      }

      // Find the theorem-title or proof-title span
      var titleSpan = div.querySelector(".theorem-title, .proof-title");
      var anchor = createAnchor(id);

      if (titleSpan) {
        // Insert anchor immediately after the title span
        titleSpan.insertAdjacentElement("afterend", anchor);
      } else {
        // Fallback: prepend to the first paragraph
        var firstPara = div.querySelector("p");
        if (firstPara) {
          firstPara.insertAdjacentElement("afterbegin", anchor);
        }
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", addDivAnchors);
  } else {
    addDivAnchors();
  }
})();
