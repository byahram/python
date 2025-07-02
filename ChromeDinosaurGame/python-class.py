'''
[객체지향 - 클래스]

* 객체지향 프로그래밍
    : 프로그래밍에서 필요한 데이터를 추상화시켜 상태와 행위를 가진 객체를 만들고 그 객체들 간의 유기적인 상호작용을 통해 로직을 구성하는 프로그래밍 방법

* 클래스 Class
    - 함수와 비슷하다.
    - 특정 양식을 가지고 여러 객체(여러 변수의 값을 가지는)를 찍어내는 툴
    - 함수는 매개변수를 입력받아서 값을 return

* 인스턴스
    : 그때 그때 등록하는 것 -> 객체, 클래스로 선언하는 값

* 클래스 
    : 미리 세팅해 놓는 것 -> 여러 변수를 가지게 되는 객체
'''

# rabbit이라는 클래스를 생성
class rabbit:
    # rabbit은 정수로 입력받는 num과 문자열로 입력받는 name 필드를 가진다.
    def __init__(self):
        self.name = input("이름 입력 : ")
        self.num = int(input("번호 입력 : "))

    # rabbit 클래스는 함수를 가지는데 check()와 score()가 있다.
    # check()는 인수를 입력받지 않고 학생의 번호와 이름을 출력한다.
    # 출력문 예시는 "00번 홍길동입니다. 출석체크 완료!"
    def check(self):
        print("{}번 {}입니다. 출석체크 완료!".format(self.num, self.name))

    # score(self, score)
    def score(self, score):
        # 인수로 받은 score가 40 미만일때는 C, 40이상 80미만일때는 B, 80이상일때는 A가 되도록 한다.
        # 여기서 A, B, C 학점은 grade 필드(변수)이다.
        if score <= 40:
            self.grade = "C"
        elif 40 < score <= 80:
            self.grade = "B"
        else:
            self.grade = "A"

        # 출력문은 "{}점이고 학점은 {}입니다.".score, grade
        print("{}점이고 학점은 {}입니다.".format(score, self.grade))

a = rabbit()
b = rabbit()
c = rabbit()

print(a.name)
print(c.num)

c.check()
b.score(74)
