package utils;



import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.Random;

import javax.crypto.Cipher;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
 

public class MyRSA {
 
    private String RSA_WEB_KEY = "dkqjwl!wlzuwntpdy@0987"; // 개인키 session key
    private static String RSA_INSTANCE = "RSA"; // rsa transformation
    private PrivateKey privateKey;
    private PublicKey publicKey;
	private String publicKeyModulus;
	private String publicKeyExponent;

	public String getPublicKeyModules() { return publicKeyModulus; }
	public String getPublicKeyExponent() { return publicKeyExponent; }

    private static MyRSA instance = new MyRSA();

    
    private MyRSA() {
    	
		Random       r = new Random();
		StringBuffer b = new StringBuffer();

		for(int n=0; n < 20 && b.length() < 20; n++) {
			b.append(Integer.toHexString(r.nextInt()));
		}
		RSA_WEB_KEY = b.toString().substring(0, 16);
    	

        KeyPairGenerator generator;
        try {
			generator = KeyPairGenerator.getInstance(RSA_INSTANCE);
			generator.initialize(1024);
 
			KeyPair keyPair = generator.genKeyPair();
			publicKey = keyPair.getPublic();
			privateKey = keyPair.getPrivate();

			KeyFactory keyFactory = KeyFactory.getInstance(RSA_INSTANCE);
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			publicKeyModulus = publicSpec.getModulus().toString(16);
			publicKeyExponent = publicSpec.getPublicExponent().toString(16);

        } catch (Exception e) {
        	e.printStackTrace();
        }

    }


 

    public static MyRSA getInstance() {
        return instance;
    }


/*
    // 로그인 폼 호출
    public  void loginForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        // RSA 키 생성
        initRsa(request);
 
        ModelAndView mav = new ModelAndView();
        mav.setViewName("loginForm");
        return;
    }
 
    // 로그인

    public void ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        String userId = (String) request.getParameter("USER_ID");
        String userPw = (String) request.getParameter("USER_PW");
 
        HttpSession session = request.getSession();
        PrivateKey privateKey = (PrivateKey) session.getAttribute(LoginController.RSA_WEB_KEY);
 
        // 복호화
        userId = decryptRsa(privateKey, userId);
        userPw = decryptRsa(privateKey, userPw);
 
        // 개인키 삭제
        session.removeAttribute(LoginController.RSA_WEB_KEY);
 
        // 로그인 처리


 
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        return;
    }
 */
    
    
    
    /**
     * 복호화
     * 
     * @param privateKey
     * @param securedValue
     * @return
     * @throws Exception
     */
    public String decrypt(String securedValue) throws Exception {
    	
		if(securedValue == null || "".equals(securedValue)) {
			return "";
		}

		Cipher cipher = Cipher.getInstance(RSA_INSTANCE);
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		return decryptedValue;
    }
 
    /**
     * 16진 문자열을 byte 배열로 변환한다.
     * 
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) { return new byte[] {}; }
 
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
 
    
    

    
    
    /**
     * rsa 공개키, 개인키 생성
     * 
     * @param request
     */
    public void initRsa() {
 
        KeyPairGenerator generator;
        try {
			generator = KeyPairGenerator.getInstance(RSA_INSTANCE);
			generator.initialize(1024);
 
			KeyPair keyPair = generator.genKeyPair();
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			KeyFactory keyFactory = KeyFactory.getInstance(RSA_INSTANCE);
 
//			session.setAttribute(RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
 
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			publicKeyModulus = publicSpec.getModulus().toString(16);
			publicKeyExponent = publicSpec.getPublicExponent().toString(16);
 
//			request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
//			request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}


//출처: http://cofs.tistory.com/297 [CofS]