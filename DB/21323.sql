ALTER TABLE member_registration DROP coupon_code;

ALTER TABLE member_registration ADD couponcode CHAR(8) DEFAULT NULL;