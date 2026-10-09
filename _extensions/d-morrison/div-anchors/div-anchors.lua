-- div-anchors.lua
-- Registers a JavaScript dependency that adds visual URL anchor links
-- to theorem and proof divs for HTML and RevealJS output, similarly to the
-- `anchor-sections` option for headings.
--
-- This approach uses JavaScript rather than a Lua AST filter because
-- Quarto processes theorem divs as custom AST nodes that are not visible
-- to Lua element filters at extension filter time.

function Meta(meta)
  if quarto.doc.isFormat("html") or quarto.doc.isFormat("revealjs") then
    quarto.doc.addHtmlDependency({
      name = "div-anchors",
      version = "1.0.0",
      scripts = {
        { path = "div-anchors.js" }
      },
      stylesheets = {
        { path = "div-anchors.css" }
      }
    })
  end
  return meta
end
