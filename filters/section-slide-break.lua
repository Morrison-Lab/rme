-- Revealjs only: put a slide break after every section (level 1) header,
-- so the header gets its own title slide and the content starts on the next.
-- A header already followed by a slide break, or by a level 1 or 2 header
-- (which starts a new slide by itself at `slide-level: 2`), is left alone.
-- A level 3+ header does not start a slide, so it still gets the break.
if not quarto.doc.is_format("revealjs") then
  return {}
end

function Pandoc(doc)
  local out = pandoc.List()
  for i, block in ipairs(doc.blocks) do
    out:insert(block)
    if block.t == "Header" and block.level == 1 then
      local nxt = doc.blocks[i + 1]
      local starts_slide = nxt
        and (nxt.t == "HorizontalRule"
          or (nxt.t == "Header" and nxt.level <= 2))
      if nxt and not starts_slide then
        out:insert(pandoc.HorizontalRule())
      end
    end
  end
  doc.blocks = out
  return doc
end
