-- 고객 테이블
CREATE TABLE 고객 (
    고객코드 VARCHAR(10) PRIMARY KEY,
    고객이름 VARCHAR(50),
    나이 INT,
    성별 ENUM('남', '여')
);


-- 생산부서 테이블
CREATE TABLE 생산부서 (
    부서명 VARCHAR(50) PRIMARY KEY,
    생산량 INT
);


-- 제품 테이블
CREATE TABLE 제품 (
    제품번호 VARCHAR(10) PRIMARY KEY,
    생산부서명 VARCHAR(50),
    단가 INT,
    FOREIGN KEY (생산부서명) REFERENCES 생산부서(부서명)
);


-- 품질검사 테이블
CREATE TABLE 품질검사 (
    제품번호 VARCHAR(10),
    담당부서명 VARCHAR(50),
    합격여부 CHAR(1) CHECK (합격여부 IN ('Y', 'N')),
    PRIMARY KEY (제품번호),
    FOREIGN KEY (제품번호) REFERENCES 제품(제품번호),
    FOREIGN KEY (담당부서명) REFERENCES 생산부서(부서명)
);

-- 판매점 테이블
CREATE TABLE 판매점 (
    매장번호 VARCHAR(10) PRIMARY KEY,
    평균판매량 INT,
    매출 INT
);


-- 납품 테이블
CREATE TABLE 납품 (
    납품번호 INT AUTO_INCREMENT PRIMARY KEY,
    제품번호 VARCHAR(10),
    매장번호 VARCHAR(10),
    납품량 INT,
    납품일자 DATE,
    FOREIGN KEY (제품번호) REFERENCES 제품(제품번호),
    FOREIGN KEY (매장번호) REFERENCES 판매점(매장번호)
);


-- 구매 테이블
CREATE TABLE 구매 (
    구매번호 INT AUTO_INCREMENT PRIMARY KEY,
    고객코드 VARCHAR(10),
    제품번호 VARCHAR(10),
    구매수량 INT,
    구매일자 DATE,
    FOREIGN KEY (고객코드) REFERENCES 고객(고객코드),
    FOREIGN KEY (제품번호) REFERENCES 제품(제품번호)
);

-- 클레임 테이블
CREATE TABLE 클레임 (
    클레임번호 INT AUTO_INCREMENT PRIMARY KEY,
    고객코드 VARCHAR(10),
    제품번호 VARCHAR(10),
    클레임종류 VARCHAR(20) CHECK (클레임종류 IN ('제품결함', '배송지연', '직원불친절')),
    FOREIGN KEY (고객코드) REFERENCES 고객(고객코드),
    FOREIGN KEY (제품번호) REFERENCES 제품(제품번호)
);

-- 배상 테이블
CREATE TABLE 배상 (
    배상번호 INT AUTO_INCREMENT PRIMARY KEY,
    고객코드 VARCHAR(10),
    부서명 VARCHAR(50),
    배상금액 INT,
    FOREIGN KEY (고객코드) REFERENCES 고객(고객코드),
    FOREIGN KEY (부서명) REFERENCES 생산부서(부서명)
);