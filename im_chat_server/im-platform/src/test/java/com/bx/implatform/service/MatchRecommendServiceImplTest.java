package com.bx.implatform.service;

import com.bx.implatform.entity.User;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.mapper.UserMatchRecordMapper;
import com.bx.implatform.service.impl.MatchRecommendServiceImpl;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import java.lang.reflect.Method;

public class MatchRecommendServiceImplTest {

    @Test
    public void testCalculateMatchScoreOppositeSexCloseAgeHigher() {
        UserMapper userMapper = Mockito.mock(UserMapper.class);
        UserMatchRecordMapper recordMapper = Mockito.mock(UserMatchRecordMapper.class);
        com.bx.implatform.service.UserBlacklistService bl = Mockito.mock(com.bx.implatform.service.UserBlacklistService.class);

        MatchRecommendServiceImpl svc = new MatchRecommendServiceImpl(userMapper, recordMapper, bl);

        User u = new User();
        u.setId(1L);
        u.setSex(0);
        u.setAge(25);
        u.setInterests("音乐,运动,旅行");

        User t1 = new User();
        t1.setId(2L);
        t1.setSex(1);
        t1.setAge(26);
        t1.setInterests("音乐,电影");

        User t2 = new User();
        t2.setId(3L);
        t2.setSex(0);
        t2.setAge(40);
        t2.setInterests("阅读");

        try {
            Method m = MatchRecommendServiceImpl.class.getDeclaredMethod("calculateMatchScore", User.class, User.class);
            m.setAccessible(true);
            int score1 = (Integer) m.invoke(svc, u, t1);
            int score2 = (Integer) m.invoke(svc, u, t2);
            Assertions.assertTrue(score1 > score2, "Opposite sex and close age with common interests should score higher");
        } catch (Exception e) {
            Assertions.fail(e);
        }
    }
}
