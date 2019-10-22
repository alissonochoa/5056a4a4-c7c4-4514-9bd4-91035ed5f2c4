import functools
import json
import time

from difflib import SequenceMatcher

def pretty_print(logger, serializer_function=lambda obj: obj.__dict__):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            serializable_obj = func(*args, **kwargs)
            try:
               formatted_output = json.dumps(
                   serializable_obj, indent=4, default=serializer_function)
               print(formatted_output)
            except TypeError as e:
               logger.error("Type error encounter with message {}".format(e))
               raise
        return wrapper
    return decorator


def timeit(logger):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            output = func(*args, **kwargs)
            logger.info("[Execution time (seconds)][%s]" % (time.time() - start))
            return output
        return wrapper
    return decorator


class StringWrapper(object):
    DEFAULT_THRESHOLD = 0.5

    class Decorators:
        @staticmethod
        def sensitivity_matching_meta_decorator():
            def decorator(func):
                @functools.wraps(func)
                def wrapper(self, pattern, *args, **kwargs):
                    pattern = self._sensitivity_matching(string=pattern)
                    return func(self, pattern, *args, **kwargs)
                return wrapper
            return decorator

    def __init__(self, value, case_sensitive=False, default_similarity_threshold=DEFAULT_THRESHOLD):   #caseSensitive=False (minusculas) (no es sensible a min ni may)
        self.default_similarity_threshold = default_similarity_threshold
        self.case_sensitive = case_sensitive
        self._value = value  #value se guarda aqui y empieza con _ porque python lo ocultará

    def _sensitivity_matching(self, string):  #recibe un string y si coincide lo manda como está, si no en minusculas
        return string if self.case_sensitive else string.lower()

    @property   #se vuelve un atributo
    def value(self):
        return self._sensitivity_matching(self._value)  #al atributo oculto de value le vamos a poner otro _ para que sea congruente

    @Decorators.sensitivity_matching_meta_decorator()  #busqueda exacta
    def contains(self, pattern, reverse=False):
        return (pattern in self.value) if not reverse else (self.value in pattern)

    @Decorators.sensitivity_matching_meta_decorator()
    def similarity_ratio(self, pattern):
        return SequenceMatcher(None, self.value, pattern).ratio()  #me dara un # entre 0 y 1 , mas cercano a 1 mas parecidas son

    def similar_enough(self, pattern, threshold=None):  #ya aplica el decorador por eso no es necesario ponerlo; busqueda similar
        min_ratio = threshold if threshold is not None else self.default_similarity_threshold
        return self.similarity_ratio(pattern) > min_ratio

    def boolean_search(self, pattern, exact=False, threshold=None, reverse=False): #queremos juntar los dos metodos
        return self.contains(pattern, reverse=reverse) if exact else self.similar_enough(pattern, threshold=threshold)
