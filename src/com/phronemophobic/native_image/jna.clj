(ns com.phronemophobic.native-image.jna
  (:import com.sun.jna.Pointer
           com.sun.jna.NativeLibrary
           com.sun.jna.Function
           com.sun.jna.Memory
           com.sun.jna.IntegerType
           com.sun.jna.Platform)
  (:gen-class))

(set! *warn-on-reflection* true)

(def void Void/TYPE)

(def clib (delay (NativeLibrary/getInstance "c")))
(def mlib (delay (NativeLibrary/getInstance "m")))
(def ryml (delay (NativeLibrary/getInstance "rapidyaml")))

(defn- cos [d]
  (let [cos-fn (if (Platform/isMac)
                 (.getFunction ^NativeLibrary @clib "cos")
                 (.getFunction ^NativeLibrary @mlib "cos"))]
    (.invoke ^Function cos-fn Double/TYPE (clojure.core/to-array [d]))))

(defn- ys2edn-init []
  (let [ys2edn-init (.getFunction ^NativeLibrary @ryml "ys2edn_init")
        ryml-pointer ^Pointer (.invoke ^Function ys2edn-init (clojure.core/to-array []))]
    (println "init function pointer" ys2edn-init)
    (println "ryml-pointer value" ryml-pointer)
    ryml-pointer))

(defn- ys2edn-destroy [rptr]
  (let [ys2edn-destroy (.getFunction ^NativeLibrary @ryml "ys2edn_destroy")
        _ (.invoke ^Function ys2edn-destroy (clojure.core/to-array [rptr]))]
    (println "destroy function pointer" ys2edn-destroy)))

(defn -main [& args]
  (println "cosine of 42 is" (cos 42.0))

  (let [rptr (ys2edn-init)]
    (ys2edn-destroy rptr)))
