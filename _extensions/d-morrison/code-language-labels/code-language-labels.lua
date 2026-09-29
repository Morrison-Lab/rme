-- Attach the stylesheet that labels each highlighted code block with its
-- language. All the work is done in CSS, keyed on the language class Pandoc
-- puts on <pre class="sourceCode LANG">; output blocks have no such class and
-- stay unlabelled. Non-HTML formats (PDF, docx) are left untouched.
function Pandoc(doc)
  if quarto.doc.is_format("html") then
    quarto.doc.add_html_dependency({
      name = "code-language-labels",
      version = "1.0.0",
      stylesheets = { "code-language-labels.css" }
    })
  end
  return doc
end
