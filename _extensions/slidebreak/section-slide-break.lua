-- Revealjs only: put a slide break after every section (level 1) header,
-- so the header gets its own title slide and the content starts on the next.
-- A header already followed by a slide break or another header is left alone.
if not quarto.doc.isFormat("revealjs") then
  return {}
end

function Pandoc(doc)
  local out = pandoc.List()
  for i, block in ipairs(doc.blocks) do
    out:insert(block)
    if block.t == "Header" and block.level == 1 then
      local nxt = doc.blocks[i + 1]
      if nxt and nxt.t ~= "Header" and nxt.t ~= "HorizontalRule" then
        out:insert(pandoc.HorizontalRule())
      end
    end
  end
  doc.blocks = out
  return doc
end
