############
1. 
############

# 상수를 정의하고 그 값을 60으로 설정한다.
MIN = 60
SEC = 60

# 시간을 입력하는 함수
# hour_to_min(hour) : 매개변수로 시간이 들어오면 분 단위로 변환하여 반환한다.
def hour_to_min(hour) :
    return hour * MIN

# 매개변수로 분이 들어오면 초 단위로 변환하여 반환한다.
def min_to_sec(minute) :
    return minute * SEC

# 매개변수로 시간이 들어오면 초 단위로 변환하여 반환한다.
def hour_to_sec(hour) :
    return min_to_sec(hour_to_min(hour))


############
2.
############

# Fruits
APPLE = 500

def pay_for_apples(num) :
    return num * APPLE
