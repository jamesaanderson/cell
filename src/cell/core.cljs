(ns cell.core)

(def width (.-innerWidth js/window))
(def height (.-innerHeight js/window))

(defn main []
  (def canvas (.createElement js/document "canvas"))
  (def ctx (.getContext canvas "2d"))
  (.appendChild js/document.body canvas))

(main)
