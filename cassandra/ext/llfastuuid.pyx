import uuid

cdef extern from "Python.h":
    object PyString_FromStringAndSize(char *s, int len)
    object _PyLong_FromByteArray(unsigned char *bytes, unsigned int n,
                                 int little_endian, int is_signed)
    object PyString_FromStringAndSize(char *, int)
    char *PyString_AS_STRING(object s)

class LLFastUUID(uuid.UUID):
    def __init__(self, bytes=None):
        #self.__dict__['int'] = long(('%02x'*16) % tuple(map(ord, bytes)), 16)
        cdef object buffer = PyString_FromStringAndSize(bytes, 16)
        cdef unsigned char *buffer_bytes = <unsigned char*>PyString_AS_STRING(buffer)
        self.__dict__['int'] = _PyLong_FromByteArray(buffer_bytes, 16, 0, 0)
        self.__dict__['bytes'] = bytes

#    def __str__(self):
#        hex = binascii.hexlify(self.__dict__['bytes'])
#        return '%s-%s-%s-%s-%s' % (hex[:8], hex[8:12], hex[12:16], hex[16:20], hex[20:])

