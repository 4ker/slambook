## 李群与李代数

| 李群 | 李代数 |
| :---: | :---: |
| SO(3) | so(3) |
| R*R^T = I, det(R) = I | phi^ = skew-mat-of-vec (phi) |

```bash
-> % ./useSophus

Eigen::Matrix3d R = Eigen::AngleAxisd(M_PI / 2, Eigen::Vector3d(0, 0, 1)).toRotationMatrix();

Sophus::SO3 SO3_R(R);               // Sophus::SO(3)可以直接从旋转矩阵构造

Sophus::SO3 SO3_v(0, 0, M_PI / 2);  // 亦可从旋转向量构造

Eigen::Quaterniond q(R);            // 或者四元数
Sophus::SO3 SO3_q(q);
                                    // 上述表达方式都是等价的

// 输出SO(3)时，以so(3)形式输出
cout << "SO(3) from matrix: " << SO3_R << endl;
cout << "SO(3) from vector: " << SO3_v << endl;
cout << "SO(3) from quaternion :" << SO3_q << endl;

        SO(3) from matrix:      0      0 1.5708

        SO(3) from vector:      0      0 1.5708

        SO(3) from quaternion :     0      0 1.5708

// 使用对数映射获得它的李代数
Eigen::Vector3d so3 = SO3_R.log();
cout << "so3 = " << so3.transpose() << endl;

// hat 为向量到反对称矩阵
cout << "so3 hat=\n" << Sophus::SO3::hat(so3) << endl;

// 相对的，vee为反对称到向量
cout << "so3 hat vee= " << Sophus::SO3::vee(Sophus::SO3::hat(so3)).transpose() << endl; 
// transpose纯粹是为了输出美观一些

        so3 =      0      0 1.5708
        so3 hat=
            0 -1.5708       0
        1.5708       0      -0
            -0       0       0
        so3 hat vee=      0      0 1.5708
        SO3 updated =  7.85398e-05 -7.85398e-05       1.5708

// 对SE(3)操作大同小异
Eigen::Vector3d t(1, 0, 0);           // 沿X轴平移1
Sophus::SE3 SE3_Rt(R, t);           // 从R,t构造SE(3)
Sophus::SE3 SE3_qt(q, t);            // 从q,t构造SE(3)
cout << "SE3 from R,t= " << endl << SE3_Rt << endl;
cout << "SE3 from q,t= " << endl << SE3_qt << endl;

        SE3 from R,t=
            0      0 1.5708
        1 0 0

        SE3 from q,t=
            0      0 1.5708
        1 0 0

// 李代数se(3) 是一个六维向量，方便起见先typedef一下
typedef Eigen::Matrix<double, 6, 1> Vector6d;
Vector6d se3 = SE3_Rt.log();
cout << "se3 = " << se3.transpose() << endl;
// 观察输出，会发现在Sophus中，se(3)的平移在前，旋转在后.

        se3 =  0.785398 -0.785398         0         0         0    1.5708

// 同样的，有hat和vee两个算符

        se3 hat =
                0   -1.5708         0  0.785398
        1.5708         0        -0 -0.785398
            -0         0         0         0
                0         0         0         0

        se3 hat vee =  0.785398 -0.785398         0         0         0    1.5708

// 最后，演示一下更新
Vector6d update_se3; //更新量
update_se3.setZero();
update_se3(0, 0) = 1e-4d;
Sophus::SE3 SE3_updated = Sophus::SE3::exp(update_se3) * SE3_Rt;
cout << "SE3 updated = " << endl << SE3_updated.matrix() << endl;

        SE3 updated =
        2.22045e-16          -1           0      1.0001
                1 2.22045e-16           0           0
                0           0           1           0
                0           0           0           1
```