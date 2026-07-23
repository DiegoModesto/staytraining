// Minimal FLIP (First-Last-Invert-Play) helper for smoothly animating list reorders.
// snapshot() records each item's position before the DOM changes; play() inverts the delta
// and transitions it back to zero, so items appear to slide to their new place.
window.stFlip = {
    snapshot(selector) {
        const zone = document.querySelector(selector);
        if (!zone) return;
        const rects = new Map();
        for (const el of zone.querySelectorAll('[data-flip-id]')) {
            rects.set(el.getAttribute('data-flip-id'), el.getBoundingClientRect().top);
        }
        zone.__flipRects = rects;
    },
    play(selector) {
        const zone = document.querySelector(selector);
        if (!zone || !zone.__flipRects) return;
        const prev = zone.__flipRects;
        zone.__flipRects = null;
        for (const el of zone.querySelectorAll('[data-flip-id]')) {
            const before = prev.get(el.getAttribute('data-flip-id'));
            if (before === undefined) continue;
            const delta = before - el.getBoundingClientRect().top;
            if (Math.abs(delta) < 1) continue;
            el.style.transition = 'none';
            el.style.transform = `translateY(${delta}px)`;
            requestAnimationFrame(() => {
                el.style.transition = 'transform .22s cubic-bezier(.2,.7,.3,1)';
                el.style.transform = '';
            });
        }
    }
};
