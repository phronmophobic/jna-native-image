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

;; cos is only available on mac osx in libc. it is in libm on linux
(defn- cos [d]
  (let [cos-fn (.getFunction ^NativeLibrary @clib "cos")]
    (.invoke ^Function cos-fn Double/TYPE (clojure.core/to-array [d]))))

(defn- atoi [s]
  (let [atoi-fn (.getFunction ^NativeLibrary @clib "atoi")]
    (assert (string? s))
    (.invoke ^Function atoi-fn Integer/TYPE (clojure.core/to-array [s]))))

(defn -main [& args]
  (println "atoi of \"42\" is: " (atoi "42")))

