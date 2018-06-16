SUBROUTINE cpu_time(time)
    REAL ::tarray(2), total, time
    total = etime(tarray)
    time = tarray(1)
END SUBROUTINE cpu_time
