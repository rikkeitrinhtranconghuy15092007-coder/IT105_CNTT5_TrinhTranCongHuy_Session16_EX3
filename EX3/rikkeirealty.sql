
from sqlalchemy import Column, String, Integer, Date, ForeignKey
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()

class KhuVuc(Base):
    __tablename__ = "KHU_VUC"
    MaKhuVuc = Column(String(10), primary_key=True)
    TenKhuVuc = Column(String(100), nullable=False)

# Quan hệ 1-N: 1 Khu vực có nhiều Căn hộ
can_ho_list = relationship("CanHo", back_populates="khu_vuc")

class CanHo(Base):
    __tablename__ = "CAN_HO"
    MaCH = Column(String(10), primary_key=True)
    DienTich = Column(Integer, nullable=False)
    SoTang = Column(Integer, nullable=False)

# Khóa ngoại trỏ về bảng KHU_VUC
MaKhuVuc = Column(String(10), ForeignKey("KHU_VUC.MaKhuVuc"))
    
    khu_vuc = relationship("KhuVuc", back_populates="can_ho_list")

# Quan hệ 1-1: 1 Căn hộ có tối đa 1 Hợp đồng (uselist=False)
hop_dong = relationship("HopDongThue", back_populates="can_ho", uselist=False)

class HopDongThue(Base):
    __tablename__ = "HOP_DONG_THUE"
    MaHD = Column(String(10), primary_key=True)
    NgayBatDau = Column(Date, nullable=False)
    NgayKetThuc = Column(Date)

# Khóa ngoại trỏ về bảng CAN_HO, ràng buộc UNIQUE để đảm bảo 1-1
MaCH = Column(String(10), ForeignKey("CAN_HO.MaCH"), unique=True)
    
    can_ho = relationship("CanHo", back_populates="hop_dong")