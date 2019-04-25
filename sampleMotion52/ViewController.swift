// sampleMotion
import UIKit
// デバイスの動きや状態を検知するライブラリ
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    // デバイスの状態を検知する能力を持ったマネージャー
    // 作りすぎ注意。フリーズ等の不具合の原因になる。
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 検知するタイミング
        // 0.5秒おきに検知する
        motionManager.deviceMotionUpdateInterval = 0.5
        
        // 検知処理
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, err) in
            // 0.5秒おきに実行される処理を書いていく
            
            // XYZの角度を持っている
            let attitude = motion?.attitude
            print(attitude!.pitch)  // x
            print(attitude!.roll)   // y
            print(attitude!.yaw)    // z
            
            // 各値をプラスに変換して定数に宣言
            // selfはViewControllerを指している
            let x = self.getPlusValue(value: attitude!.pitch)
            let y = self.getPlusValue(value: attitude!.roll)
            let z = self.getPlusValue(value: attitude!.yaw)

            // colorViewの背景色を傾きに合わせて変える
            // x,y,zはDoubleなのでCGFloatにキャストする
            self.colorView.backgroundColor = UIColor(
                displayP3Red: CGFloat(x),
                green: CGFloat(y),
                blue: CGFloat(z),
                alpha: CGFloat(1))
            
            // 加速度
            // XYZの方向にどれぐらい動いたか
            let accel = motion?.userAcceleration
            print(accel!.x)
            print(accel!.y)
            print(accel!.z)
            
            // ジャイロ
            // XYZの角度にどれぐらい動いたか
            let gyro = motion?.rotationRate
            print(gyro!.x)
            print(gyro!.y)
            print(gyro!.z)
            
        })
    }

    // マイナス値の場合プラスに変換する関数
    func getPlusValue(value: Double) -> Double {
        // 三項演算子
        // 条件 ? 真の時 : 偽の時
        return value > 0 ? value : -value
        
//        上記の三項演算子はこれと同じ
//        if value > 0 {
//            return value
//        } else {
//            return -value
//        }
    }

}

