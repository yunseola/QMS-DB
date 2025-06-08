-- 1. 한달 간 결함이 있는 제품을 가장 많이 생산한 부서 조회
SELECT 생산부서명, COUNT(*) AS 결함제품수
FROM 제품
WHERE 제품번호 IN (
    SELECT 제품번호 FROM 품질검사 WHERE 합격여부 = 'N'
)
GROUP BY 생산부서명
ORDER BY 결함제품수 DESC
LIMIT 1;

-- 2. 품질검사 불합격 제품 조회
SELECT 제품번호
FROM 품질검사
WHERE 합격여부 = 'N';

-- 3. 월간 가장 많이 구매된 제품 조회
SELECT 제품번호, SUM(구매수량) AS 총구매수량
FROM 구매
GROUP BY 제품번호
ORDER BY 총구매수량 DESC
LIMIT 1;

-- 4. '제품결함' 클레임 제품 재검사 대상 조회
SELECT DISTINCT 제품번호
FROM 클레임
WHERE 클레임종류 = '제품결함';

-- 5. 최고 배상금 제품과 생산 부서 조회
SELECT 제품.제품번호, 제품.생산부서명, 배상금액
FROM 제품
JOIN 배상 ON 제품.생산부서명 = 배상.부서명
ORDER BY 배상금액 DESC
LIMIT 1;

-- 6. 납품량 40개 이상인 판매점 조회 (할인 대상)
SELECT DISTINCT 매장번호
FROM 납품
GROUP BY 매장번호
HAVING SUM(납품량) >= 40;

-- 7. 총 구매금액이 150만원 이상인 고객 조회
SELECT 고객.고객코드, 고객이름
FROM 고객
JOIN 구매 ON 고객.고객코드 = 구매.고객코드
JOIN 제품 ON 구매.제품번호 = 제품.제품번호
GROUP BY 고객.고객코드, 고객이름
HAVING SUM(제품.단가 * 구매.구매수량) >= 1500000;

-- 8. '권명준' 고객이 구매한 제품과 금액 조회
SELECT 제품.제품번호, 제품.단가
FROM 구매
JOIN 고객 ON 구매.고객코드 = 고객.고객코드
JOIN 제품 ON 구매.제품번호 = 제품.제품번호
WHERE 고객이름 = '권명준';

-- 9. 구매 고객 평균 연령 조회
SELECT ROUND(AVG(나이), 1) AS 평균연령
FROM 고객
WHERE 고객코드 IN (SELECT 고객코드 FROM 구매);

-- 10. 특정 매장 특정일자 납품 수량 조회
SELECT 납품량
FROM 납품
WHERE 매장번호 = 'D7438' AND 납품일자 = '2022-05-15';

-- 11. 5월 중 총 구매 수량이 가장 많은 날짜
SELECT 구매일자, SUM(구매수량) AS 총구매수량
FROM 구매
WHERE 구매일자 BETWEEN '2022-05-01' AND '2022-05-31'
GROUP BY 구매일자
ORDER BY 총구매수량 DESC
LIMIT 1;

-- 12. 이번 달 평균 판매량이 가장 높은 판매점
SELECT 매장번호, 평균판매량, 매출
FROM 판매점
ORDER BY 평균판매량 DESC
LIMIT 1;

-- 13. 'H009' 고객이 'NM003' 제품에 '제품결함' 클레임 등록
INSERT INTO 클레임 (고객코드, 제품번호, 클레임종류)
VALUES ('H009', 'NM003', '제품결함');

-- 14. 'B001' 부서에서 생산한 'OP005' 불합격 제품 등록 (단가 NULL)
INSERT INTO 제품 (제품번호, 생산부서명, 단가, 합격여부)
VALUES ('OP005', 'B001', NULL, 'N');

-- 15. 'H013' 고객 배상금액을 단가의 70%로 인상
UPDATE 배상
SET 배상금액 = (배상금액 * 2) * 0.7
WHERE 고객코드 = 'H013';

-- 16. 배상 후 1개월 경과한 정보 삭제 (예시: 'H002' 고객)
DELETE FROM 배상
WHERE 고객코드 = 'H002';