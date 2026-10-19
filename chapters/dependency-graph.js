/* Prerequisite and postrequisite graph of each definition and result.
   Reads dependency-graph.json (tools/build_dependency_graph.py): an edge [A, B]
   means A uses B, so B is a prerequisite of A.  No library: plain SVG.
   Under every #def-/#thm-/#lem-/#prp-/#cor- div, a foldable block (folded by
   default) holds one graph focused on that div.  It reads top to bottom:
   prerequisites above, the div in the middle, postrequisites below, DEPTH
   levels each way, with arrows pointing from what is used to what uses it. */
(function () {
  "use strict";
  var DEPTH = 2, PER_ROW = 4, NS = "http://www.w3.org/2000/svg";
  var W = 200, H = 34, GX = 16, GY = 36;
  /* The div colors of the notes (custom-callout in _quarto-website.yml); a theorem shares a lemma's blue. */
  var COLOR = { def: "#1B5E20", thm: "#1565C0", lem: "#1565C0", cor: "#00838F", prp: "#827717" };
  var NAME = { def: "Definition", thm: "Theorem", lem: "Lemma", cor: "Corollary", prp: "Proposition" };
  var script = document.currentScript;
  var base = script ? script.src.replace(/[^/]*$/, "") : "";
  var page = location.pathname.split("/").pop().replace(/\.html$/, "");

  function el(tag, attrs, parent) {
    var e = document.createElementNS(NS, tag);
    for (var k in attrs) e.setAttribute(k, attrs[k]);
    if (parent) parent.appendChild(e);
    return e;
  }
  function href(n, g) {
    if (n.url) return n.url;
    if (n.site !== g.site) return "https://morrison-lab.github.io/" + n.site + "/" + n.page + ".html#" + n.div;
    return (n.page === page ? "" : n.page + ".html") + "#" + n.div;
  }
  function clip(s) { return s.length > 30 ? s.slice(0, 29) + "…" : s; }

  /* Draw `levels` (top to bottom; arrays of nodes) with `edges` ([prereq, dependent] key pairs).
     A level wider than PER_ROW wraps onto further rows. */
  function draw(levels, edges, focus, g) {
    var rows = [];
    levels.forEach(function (l) {
      for (var i = 0; i < l.length; i += PER_ROW) rows.push(l.slice(i, i + PER_ROW));
    });
    var cols = Math.max.apply(null, rows.map(function (r) { return r.length; }));
    var w = cols * (W + GX) - GX, h = rows.length * (H + GY) - GY;
    var uid = "dg-arrow-" + (draw.n = (draw.n || 0) + 1);
    var svg = el("svg", { viewBox: "0 0 " + w + " " + h, width: w, role: "img",
      "aria-label": "Prerequisites above, postrequisites below" }), pos = {};
    var defs = el("defs", {}, svg);
    var mk = el("marker", { id: uid, viewBox: "0 0 10 10", refX: 9, refY: 5, markerWidth: 6,
      markerHeight: 6, orient: "auto-start-reverse" }, defs);
    el("path", { d: "M0 0L10 5L0 10z", fill: "#888" }, mk);
    rows.forEach(function (r, i) {
      var off = (w - (r.length * (W + GX) - GX)) / 2;
      r.forEach(function (n, j) { pos[n.id] = { x: off + j * (W + GX), y: i * (H + GY) }; });
    });
    edges.forEach(function (e) {
      var a = pos[e[0]], b = pos[e[1]];
      if (!a || !b) return;
      var x1 = a.x + W / 2, y1 = a.y + H, x2 = b.x + W / 2, y2 = b.y, my = (y1 + y2) / 2;
      el("path", { d: "M" + x1 + " " + y1 + "C" + x1 + " " + my + " " + x2 + " " + my + " " + x2 + " " + y2,
        fill: "none", stroke: "#888", "stroke-width": 1.2, "marker-end": "url(#" + uid + ")" }, svg);
    });
    rows.forEach(function (r) {
      r.forEach(function (n) {
        var p = pos[n.id];
        var a = el("a", { href: href(n, g) }, svg);
        var attrs = { x: p.x, y: p.y, width: W, height: H, rx: 6, fill: COLOR[n.kind] || "#555",
          stroke: n.id === focus ? "#000" : "#fff", "stroke-width": n.id === focus ? 3 : 1 };
        if (n.external) attrs["stroke-dasharray"] = "4 2";
        var rect = el("rect", attrs, a);
        el("title", {}, rect).textContent = (NAME[n.kind] || n.kind) + ": " + n.title +
          (n.external ? " (another site)" : "");
        var t = el("text", { x: p.x + 8, y: p.y + H / 2 + 4, "font-size": 12, fill: "#fff" }, a);
        t.textContent = clip(n.title);
      });
    });
    return svg;
  }

  function neighbors(adj, start, depth) {
    var dist = {}, queue = [start];
    dist[start] = 0;
    while (queue.length) {
      var v = queue.shift();
      if (dist[v] >= depth) continue;
      (adj[v] || []).forEach(function (w) { if (!(w in dist)) { dist[w] = dist[v] + 1; queue.push(w); } });
    }
    return dist;
  }

  function perDiv(g, nodes, uses, usedBy) {
    Object.keys(nodes).forEach(function (k) {
      var n = nodes[k];
      if (n.site !== g.site || n.page !== page) return;
      var host = document.getElementById(n.div);
      if (!host || (!(uses[k] || []).length && !(usedBy[k] || []).length)) return;
      var pre = neighbors(uses, k, DEPTH), post = neighbors(usedBy, k, DEPTH);
      var levels = [], d;
      for (d = DEPTH; d >= 1; d--) levels.push(Object.keys(pre).filter(function (x) { return pre[x] === d; }));
      levels.push([k]);
      for (d = 1; d <= DEPTH; d++) levels.push(Object.keys(post).filter(function (x) { return post[x] === d; }));
      levels = levels.filter(function (l) { return l.length; }).map(function (l) { return l.map(function (x) { return nodes[x]; }); });
      var ids = {};
      levels.forEach(function (l) { l.forEach(function (x) { ids[x.id] = 1; }); });
      var edges = g.edges.filter(function (e) { return ids[e[0]] && ids[e[1]]; }).map(function (e) { return [e[1], e[0]]; });
      var det = document.createElement("details");
      det.className = "dependency-graph";
      var sum = document.createElement("summary");
      sum.textContent = "Dependencies (" + (Object.keys(pre).length - 1) + " prerequisites, " +
        (Object.keys(post).length - 1) + " postrequisites, up to " + DEPTH + " levels)";
      det.appendChild(sum);
      var legend = document.createElement("p");
      legend.style.cssText = "font-size:0.85em;margin:0.4em 0";
      var kinds = {};
      levels.forEach(function (l) { l.forEach(function (x) { kinds[x.kind] = 1; }); });
      Object.keys(NAME).filter(function (c) { return kinds[c]; }).forEach(function (c) {
        var sw = document.createElement("span");
        sw.style.cssText = "display:inline-block;width:0.9em;height:0.9em;border-radius:3px;margin:0 0.3em 0 0.9em;" +
          "vertical-align:-0.1em;background:" + COLOR[c];
        legend.appendChild(sw);
        legend.appendChild(document.createTextNode(NAME[c]));
      });
      var note = document.createElement("span");
      note.style.cssText = "display:block;margin-top:0.2em";
      note.textContent = "Arrows point from what is used to what uses it. A dashed box is on another site.";
      legend.appendChild(note);
      det.appendChild(legend);
      var drawn = false;
      det.addEventListener("toggle", function () {
        if (det.open && !drawn) { drawn = true; var s = document.createElement("div"); s.style.overflowX = "auto";
          s.appendChild(draw(levels, edges, k, g)); det.appendChild(s); }
      });
      host.appendChild(det);
    });
  }

  /* Optional: an element with id "dependency-graph-page" gets a folded graph of every
     div on the page, prerequisites at the top (a div sits one row below the lowest
     div it uses). */
  function wholePage(g, nodes, uses) {
    var host = document.getElementById("dependency-graph-page");
    if (!host) return;
    var mine = Object.keys(nodes).filter(function (k) { return nodes[k].site === g.site && nodes[k].page === page; });
    if (!mine.length) return;
    var level = {};
    function lv(k, seen) {
      if (k in level) return level[k];
      if (seen[k]) return 0;
      seen[k] = 1;
      var m = 0;
      (uses[k] || []).forEach(function (p) { if (nodes[p].site === g.site && nodes[p].page === page) m = Math.max(m, lv(p, seen) + 1); });
      return (level[k] = m);
    }
    mine.forEach(function (k) { lv(k, {}); });
    var levels = [], ids = {};
    mine.forEach(function (k) { ids[k] = 1; (levels[level[k]] = levels[level[k]] || []).push(nodes[k]); });
    var edges = g.edges.filter(function (e) { return ids[e[0]] && ids[e[1]]; }).map(function (e) { return [e[1], e[0]]; });
    var det = document.createElement("details");
    det.className = "dependency-graph";
    var sum = document.createElement("summary");
    sum.textContent = "Dependencies of every definition and result on this page (" + mine.length + ")";
    det.appendChild(sum);
    var drawn = false;
    det.addEventListener("toggle", function () {
      if (det.open && !drawn) { drawn = true; var s = document.createElement("div"); s.style.overflowX = "auto";
        s.appendChild(draw(levels.filter(Boolean), edges, null, g)); det.appendChild(s); }
    });
    host.appendChild(det);
  }

  fetch(base + "dependency-graph.json").then(function (r) { return r.json(); }).then(function (g) {
    var nodes = {}, uses = {}, usedBy = {};
    g.nodes.forEach(function (n) { nodes[n.id] = n; });
    g.edges.forEach(function (e) {
      (uses[e[0]] = uses[e[0]] || []).push(e[1]);
      (usedBy[e[1]] = usedBy[e[1]] || []).push(e[0]);
    });
    perDiv(g, nodes, uses, usedBy);
    wholePage(g, nodes, uses);
  }).catch(function () { /* the graph is an extra; a missing file leaves the page as it was */ });
})();
