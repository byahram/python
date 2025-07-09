############
1. 
############

FAT = 9
PROTEIN = 4
CARBON = 4

# 입력된 영양소 종류와 그램 수를 기반으로 칼로리 양을 계산하고 반환하는 함수.
def calculate_calories(kind, gram) :
    if kind == 1 :      # 1이면 지방
        return gram * FAT
    elif kind == 2 :    # 2이면 단백질
        return gram * PROTEIN
    elif kind == 3 :    # 3이면 탄수화물
        return gram * CARBON
    else :              # 조건에 해당하지 않으면 문자열 반환
        return "영양분 종류가 잘못 입력되었습니다."


############
2. 
############

SODA = 0.11
JUICE = 0.09
MILK = 0.05

def calculate_sugar(kind, ml) :
    if kind == 1 :      # 1이면 탄산음료
        return ml * SODA
    elif kind == 2 :    # 2이면 과일주스
        return ml * JUICE
    elif kind == 3 :    # 3이면 우유
        return ml * MILK
    else :              # 조건에 해당하지 않으면 문자열 반환
        return "알 수 없는 음료입니다."
        