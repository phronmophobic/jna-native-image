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

(defn- parse-ys [ys]
  (let [parseys-fn (.getFunction ^NativeLibrary @ryml "ys2edn")]
    (println parseys-fn)))

(defn -main [& args]
  (parse-ys "foo")
  (println "cosine of 42 is" (cos 42.0))
  )

