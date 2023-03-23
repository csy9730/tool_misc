
#### 经纬度

#### 经纬度距离换算

``` java
public class CaculateDistance {

	private final static double EARTH_RADIUS = 6378.137;

	private static double rad(double d) {
		return d * Math.PI / 180.0;
	}

	/**
	 * 根据两点间经纬度坐标（double值），计算两点间距离，单位为米
	 */
	public static double GetDistance(double lat1, double lng1, double lat2, double lng2) {
		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double a = radLat1 - radLat2;
		double b = rad(lng1) - rad(lng2);
		double s = 2 * Math.asin(Math.sqrt(
				Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
		s = s * EARTH_RADIUS;
		s = (s * 10000) / 10;
		return s;
	}

	public static void main(String[] args) {
		System.out.println("距离差" + GetDistance(30.535275, 114.352175,30.5352806, 114.3521917) + "米");
	}
}
```

要真正精准计算，必须考虑地球椭球体，否则上百公里或上千公里后，依然有几百米以内的误差。建议采用椭球体算法，比较著名的算法有Vincenty方案算法，参考：Vincenty solutions of geodesics on the ellipsoid
#### 时区

东八区+8 23:00
西五区-5 10:00
西八区-8 7:00

东七区时间 105°中间，[97.5, 112.5]
东八区时间 120 中心，区间[112.5, 127.5]
东八区时间（东经120度平太阳时）

中国大部分人口都居住在胡焕庸线（黑河-腾冲线）以东，主要是东八区地域（东经112°30′至东经127°30′）


广州位于东经112度57分至114度3分，北纬22度26分至23度56分。 市中心位于北纬23度06分32秒，东经113度15分53秒
