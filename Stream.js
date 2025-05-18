javascript:(function() {
  const popup = window.open("", "M3U8 Finder", "width=600,height=400");
  popup.document.write("<h1>🔍 M3U8 Links Found</h1><ul id='linkList'></ul>");
  popup.document.title = "M3U8 Sniffer";

  const found = new Set();

  function addLink(url) {
    if (found.has(url)) return;
    found.add(url);
    const list = popup.document.getElementById('linkList');
    const item = popup.document.createElement('li');
    const link = popup.document.createElement('a');
    link.href = url;
    link.textContent = url;
    link.target = "_blank";
    item.appendChild(link);
    list.appendChild(item);
  }

  // Hook into fetch
  const originalFetch = window.fetch;
  window.fetch = async function(...args) {
    const response = await originalFetch.apply(this, args);
    const url = args[0];
    if (url.includes(".m3u8")) {
      addLink(url);
    }
    return response;
  };

  // Hook into XHR
  const originalOpen = XMLHttpRequest.prototype.open;
  XMLHttpRequest.prototype.open = function(method, url) {
    if (url.includes(".m3u8")) {
      addLink(url);
    }
    return originalOpen.apply(this, arguments);
  };

  console.log("🎬 M3U8 Sniffer with popup active. Interact with the page!");
})();
