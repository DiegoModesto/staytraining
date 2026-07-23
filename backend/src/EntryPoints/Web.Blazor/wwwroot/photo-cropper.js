// Minimal self-contained square image cropper for profile photos (no external library).
// A host <div> shows the image "cover"-fitted into a square; the user pans (drag) and zooms
// (slider -> setZoom). export() draws the visible square to an OUTPUT_SIZE canvas and returns a
// resized WebP data URL (base64) — small, mobile-friendly, one image per profile.
window.stCropper = (() => {
    const OUTPUT_SIZE = 512;
    const state = new Map(); // hostId -> { img, host, natW, natH, scale, minScale, x, y, drag }

    function clamp(v, min, max) { return Math.min(Math.max(v, min), max); }

    function fit(s) {
        // Cover: image must fully cover the square host at the current scale.
        const size = s.host.clientWidth;
        const baseScale = size / Math.min(s.natW, s.natH);
        s.minScale = baseScale;
        if (s.scale < baseScale) { s.scale = baseScale; }
        const w = s.natW * s.scale;
        const h = s.natH * s.scale;
        s.x = clamp(s.x, size - w, 0);
        s.y = clamp(s.y, size - h, 0);
        s.img.style.width = w + 'px';
        s.img.style.height = h + 'px';
        s.img.style.transform = `translate(${s.x}px, ${s.y}px)`;
    }

    function init(hostId, dataUrl) {
        const host = document.getElementById(hostId);
        if (!host) { return; }
        host.innerHTML = '';
        host.style.position = 'relative';
        host.style.overflow = 'hidden';
        host.style.touchAction = 'none';
        host.style.cursor = 'grab';

        const img = document.createElement('img');
        img.draggable = false;
        img.style.position = 'absolute';
        img.style.left = '0';
        img.style.top = '0';
        img.style.userSelect = 'none';
        host.appendChild(img);

        const s = { img, host, natW: 1, natH: 1, scale: 1, minScale: 1, x: 0, y: 0, drag: null };
        state.set(hostId, s);

        img.onload = () => {
            s.natW = img.naturalWidth;
            s.natH = img.naturalHeight;
            s.scale = 0; // force fit() to snap to minScale
            const size = host.clientWidth;
            s.x = (size - s.natW * s.minScale) / 2;
            s.y = (size - s.natH * s.minScale) / 2;
            fit(s);
        };
        img.src = dataUrl;

        const onDown = (e) => { s.drag = { px: e.clientX, py: e.clientY, x: s.x, y: s.y }; host.style.cursor = 'grabbing'; };
        const onMove = (e) => {
            if (!s.drag) { return; }
            s.x = s.drag.x + (e.clientX - s.drag.px);
            s.y = s.drag.y + (e.clientY - s.drag.py);
            fit(s);
        };
        const onUp = () => { s.drag = null; host.style.cursor = 'grab'; };
        host.addEventListener('pointerdown', onDown);
        window.addEventListener('pointermove', onMove);
        window.addEventListener('pointerup', onUp);
        s.cleanup = () => {
            host.removeEventListener('pointerdown', onDown);
            window.removeEventListener('pointermove', onMove);
            window.removeEventListener('pointerup', onUp);
        };
    }

    // zoom: 1..3 multiplier over the minimum (cover) scale.
    function setZoom(hostId, zoom) {
        const s = state.get(hostId);
        if (!s) { return; }
        const size = s.host.clientWidth;
        const cx = size / 2, cy = size / 2;
        const oldScale = s.scale;
        const newScale = s.minScale * zoom;
        // Keep the host center anchored while zooming.
        s.x = cx - ((cx - s.x) / oldScale) * newScale;
        s.y = cy - ((cy - s.y) / oldScale) * newScale;
        s.scale = newScale;
        fit(s);
    }

    function exportPng(hostId) {
        const s = state.get(hostId);
        if (!s) { return null; }
        const size = s.host.clientWidth;
        const canvas = document.createElement('canvas');
        canvas.width = OUTPUT_SIZE;
        canvas.height = OUTPUT_SIZE;
        const ctx = canvas.getContext('2d');
        const ratio = OUTPUT_SIZE / size;
        // Source rect in natural pixels of the portion visible in the host square.
        const sx = -s.x / s.scale;
        const sy = -s.y / s.scale;
        const sSize = size / s.scale;
        ctx.drawImage(s.img, sx, sy, sSize, sSize, 0, 0, OUTPUT_SIZE, OUTPUT_SIZE);
        // WebP with fallback to PNG if the browser can't encode WebP.
        let url = canvas.toDataURL('image/webp', 0.85);
        if (!url.startsWith('data:image/webp')) { url = canvas.toDataURL('image/png'); }
        return url;
    }

    function destroy(hostId) {
        const s = state.get(hostId);
        if (s && s.cleanup) { s.cleanup(); }
        state.delete(hostId);
    }

    return { init, setZoom, export: exportPng, destroy };
})();
