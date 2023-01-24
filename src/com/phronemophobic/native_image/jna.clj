(ns com.phronemophobic.native-image.jna
  (:import com.sun.jna.Pointer
           com.sun.jna.NativeLibrary
           com.sun.jna.Function
           com.sun.jna.Memory
           com.sun.jna.IntegerType)
  (:gen-class))

(set! *warn-on-reflection* true)

(def void Void/TYPE)

(def clib (delay (NativeLibrary/getInstance "c")))

(defn- cos [d]
  (let [cos-fn (.getFunction ^NativeLibrary @clib "cos")]
    (.invoke ^Function cos-fn Double/TYPE (clojure.core/to-array [d]))))

(defn -main [& args]
  (println "cosine of 42 is" (cos 42.0)))

