# 릴레이션 스키마 설명

## 고객(Customer)
- 고객코드 (PK): VARCHAR(10)
- 고객이름: VARCHAR(50)
- 나이: INT
- 성별: ENUM('남', '여')

## 생산부서(ProductionDept)
- 부서명 (PK): VARCHAR(50)
- 생산량: INT

## 제품(Product)
- 제품번호 (PK): VARCHAR(10)
- 생산부서명 (FK): VARCHAR(50) → 생산부서.부서명
- 단가: INT

## 품질검사(QualityCheck)
- 제품번호 (PK, FK): VARCHAR(10) → 제품.제품번호
- 담당부서명 (FK): VARCHAR(50) → 생산부서.부서명
- 합격여부: CHAR(1) ('Y' 또는 'N')

## 판매점(Store)
- 매장번호 (PK): VARCHAR(10)
- 평균판매량: INT
- 매출: INT

## 납품(Delivery)
- 납품번호 (PK): INT (AUTO_INCREMENT)
- 제품번호 (FK): VARCHAR(10)
- 매장번호 (FK): VARCHAR(10)
- 납품량: INT
- 납품일자: DATE

## 구매(Purchase)
- 구매번호 (PK): INT (AUTO_INCREMENT)
- 고객코드 (FK): VARCHAR(10)
- 제품번호 (FK): VARCHAR(10)
- 구매수량: INT
- 구매일자: DATE

## 클레임(Claim)
- 클레임번호 (PK): INT (AUTO_INCREMENT)
- 고객코드 (FK): VARCHAR(10)
- 제품번호 (FK): VARCHAR(10)
- 클레임종류: VARCHAR(20) ('제품결함', '배송지연', '직원불친절')

## 배상(Compensation)
- 배상번호 (PK): INT (AUTO_INCREMENT)
- 고객코드 (FK): VARCHAR(10)
- 부서명 (FK): VARCHAR(50)
- 배상금액: INT

