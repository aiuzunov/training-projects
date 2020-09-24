import logging
import os
import sys



class LogFilter(object):
    def __init__(self, level):
        self.__level = level

    def filter(self, logRecord):
        return logRecord.levelno <= self.__level

class LogInit:
    def __init__(self, logger, level, destination, formatter):
        self.level = level
        self.logger = logger
        self.destination = destination
        self.formatter = formatter

    def initialize(self) -> None:
        try:
            handler = logging.FileHandler(self.destination)
            handler.setLevel(self.level)
            handler.setFormatter(self.formatter)
            handler.addFilter((LogFilter(self.level)))
            self.logger.addHandler(handler)
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            print(e,exc_type, fname, exc_tb.tb_lineno)
