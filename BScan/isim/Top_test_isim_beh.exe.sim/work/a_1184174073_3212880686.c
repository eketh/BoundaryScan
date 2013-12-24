/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/!DYPLOM/BScan/InstructionRegister.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1184174073_3212880686_p_0(char *t0)
{
    char t20[16];
    char t21[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t22;
    int t23;
    unsigned int t24;
    unsigned char t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;

LAB0:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t2 = (t0 + 2152U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t2 = (t0 + 1792U);
    t4 = xsi_signal_has_event(t2);
    if (t4 == 1)
        goto LAB10;

LAB11:    t1 = (unsigned char)0;

LAB12:    if (t1 != 0)
        goto LAB8;

LAB9:    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)3);
    if (t4 != 0)
        goto LAB18;

LAB19:
LAB3:    t2 = (t0 + 5408);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t9 = t2;
    memset(t9, (unsigned char)2, 8U);
    t10 = (t0 + 5520);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(50, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t3 = t2;
    memset(t3, (unsigned char)3, 8U);
    t6 = (t0 + 5584);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    xsi_set_current_line(52, ng0);
    t3 = (t0 + 1672U);
    t9 = *((char **)t3);
    t8 = *((unsigned char *)t9);
    t15 = (t8 == (unsigned char)3);
    if (t15 != 0)
        goto LAB13;

LAB15:
LAB14:    goto LAB3;

LAB10:    t3 = (t0 + 1832U);
    t6 = *((char **)t3);
    t5 = *((unsigned char *)t6);
    t7 = (t5 == (unsigned char)3);
    t1 = t7;
    goto LAB12;

LAB13:    xsi_set_current_line(53, ng0);
    t3 = (t0 + 1032U);
    t10 = *((char **)t3);
    t16 = *((unsigned char *)t10);
    t3 = (t0 + 2952U);
    t11 = *((char **)t3);
    t17 = (7 - 7);
    t18 = (t17 * 1U);
    t19 = (0 + t18);
    t3 = (t11 + t19);
    t13 = ((IEEE_P_2592010699) + 4024);
    t14 = (t21 + 0U);
    t22 = (t14 + 0U);
    *((int *)t22) = 7;
    t22 = (t14 + 4U);
    *((int *)t22) = 1;
    t22 = (t14 + 8U);
    *((int *)t22) = -1;
    t23 = (1 - 7);
    t24 = (t23 * -1);
    t24 = (t24 + 1);
    t22 = (t14 + 12U);
    *((unsigned int *)t22) = t24;
    t12 = xsi_base_array_concat(t12, t20, t13, (char)99, t16, (char)97, t3, t21, (char)101);
    t24 = (1U + 7U);
    t25 = (8U != t24);
    if (t25 == 1)
        goto LAB16;

LAB17:    t22 = (t0 + 5520);
    t26 = (t22 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t12, 8U);
    xsi_driver_first_trans_fast(t22);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 2952U);
    t3 = *((char **)t2);
    t23 = (0 - 7);
    t17 = (t23 * -1);
    t18 = (1U * t17);
    t19 = (0 + t18);
    t2 = (t3 + t19);
    t1 = *((unsigned char *)t2);
    t6 = (t0 + 5648);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast_port(t6);
    goto LAB14;

LAB16:    xsi_size_not_matching(8U, t24, 0);
    goto LAB17;

LAB18:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1312U);
    t5 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t5 != 0)
        goto LAB20;

LAB22:
LAB21:    goto LAB3;

LAB20:    xsi_set_current_line(58, ng0);
    t6 = (t0 + 2952U);
    t9 = *((char **)t6);
    t6 = (t0 + 5584);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 8U);
    xsi_driver_first_trans_fast(t6);
    goto LAB21;

}

static void work_a_1184174073_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned char t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    unsigned char t40;
    unsigned int t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    unsigned char t52;
    unsigned int t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    unsigned char t64;
    unsigned int t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    unsigned char t76;
    unsigned int t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;

LAB0:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 8560);
    t4 = 1;
    if (8U == 8U)
        goto LAB5;

LAB6:    t4 = 0;

LAB7:    if (t4 != 0)
        goto LAB3;

LAB4:    t13 = (t0 + 3112U);
    t14 = *((char **)t13);
    t13 = (t0 + 8568);
    t16 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t16 = 0;

LAB15:    if (t16 != 0)
        goto LAB11;

LAB12:    t25 = (t0 + 3112U);
    t26 = *((char **)t25);
    t25 = (t0 + 8576);
    t28 = 1;
    if (8U == 8U)
        goto LAB21;

LAB22:    t28 = 0;

LAB23:    if (t28 != 0)
        goto LAB19;

LAB20:    t37 = (t0 + 3112U);
    t38 = *((char **)t37);
    t37 = (t0 + 8584);
    t40 = 1;
    if (8U == 8U)
        goto LAB29;

LAB30:    t40 = 0;

LAB31:    if (t40 != 0)
        goto LAB27;

LAB28:    t49 = (t0 + 3112U);
    t50 = *((char **)t49);
    t49 = (t0 + 8592);
    t52 = 1;
    if (8U == 8U)
        goto LAB37;

LAB38:    t52 = 0;

LAB39:    if (t52 != 0)
        goto LAB35;

LAB36:    t61 = (t0 + 3112U);
    t62 = *((char **)t61);
    t61 = (t0 + 8600);
    t64 = 1;
    if (8U == 8U)
        goto LAB45;

LAB46:    t64 = 0;

LAB47:    if (t64 != 0)
        goto LAB43;

LAB44:    t73 = (t0 + 3112U);
    t74 = *((char **)t73);
    t73 = (t0 + 8608);
    t76 = 1;
    if (8U == 8U)
        goto LAB53;

LAB54:    t76 = 0;

LAB55:    if (t76 != 0)
        goto LAB51;

LAB52:
LAB59:    t85 = (t0 + 5712);
    t86 = (t85 + 56U);
    t87 = *((char **)t86);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    *((unsigned char *)t89) = (unsigned char)7;
    xsi_driver_first_trans_fast(t85);

LAB2:    t90 = (t0 + 5424);
    *((int *)t90) = 1;

LAB1:    return;
LAB3:    t8 = (t0 + 5712);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)0;
    xsi_driver_first_trans_fast(t8);
    goto LAB2;

LAB5:    t5 = 0;

LAB8:    if (t5 < 8U)
        goto LAB9;
    else
        goto LAB7;

LAB9:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB6;

LAB10:    t5 = (t5 + 1);
    goto LAB8;

LAB11:    t20 = (t0 + 5712);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    *((unsigned char *)t24) = (unsigned char)1;
    xsi_driver_first_trans_fast(t20);
    goto LAB2;

LAB13:    t17 = 0;

LAB16:    if (t17 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t18 = (t14 + t17);
    t19 = (t13 + t17);
    if (*((unsigned char *)t18) != *((unsigned char *)t19))
        goto LAB14;

LAB18:    t17 = (t17 + 1);
    goto LAB16;

LAB19:    t32 = (t0 + 5712);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    *((unsigned char *)t36) = (unsigned char)2;
    xsi_driver_first_trans_fast(t32);
    goto LAB2;

LAB21:    t29 = 0;

LAB24:    if (t29 < 8U)
        goto LAB25;
    else
        goto LAB23;

LAB25:    t30 = (t26 + t29);
    t31 = (t25 + t29);
    if (*((unsigned char *)t30) != *((unsigned char *)t31))
        goto LAB22;

LAB26:    t29 = (t29 + 1);
    goto LAB24;

LAB27:    t44 = (t0 + 5712);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    *((unsigned char *)t48) = (unsigned char)3;
    xsi_driver_first_trans_fast(t44);
    goto LAB2;

LAB29:    t41 = 0;

LAB32:    if (t41 < 8U)
        goto LAB33;
    else
        goto LAB31;

LAB33:    t42 = (t38 + t41);
    t43 = (t37 + t41);
    if (*((unsigned char *)t42) != *((unsigned char *)t43))
        goto LAB30;

LAB34:    t41 = (t41 + 1);
    goto LAB32;

LAB35:    t56 = (t0 + 5712);
    t57 = (t56 + 56U);
    t58 = *((char **)t57);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    *((unsigned char *)t60) = (unsigned char)4;
    xsi_driver_first_trans_fast(t56);
    goto LAB2;

LAB37:    t53 = 0;

LAB40:    if (t53 < 8U)
        goto LAB41;
    else
        goto LAB39;

LAB41:    t54 = (t50 + t53);
    t55 = (t49 + t53);
    if (*((unsigned char *)t54) != *((unsigned char *)t55))
        goto LAB38;

LAB42:    t53 = (t53 + 1);
    goto LAB40;

LAB43:    t68 = (t0 + 5712);
    t69 = (t68 + 56U);
    t70 = *((char **)t69);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    *((unsigned char *)t72) = (unsigned char)5;
    xsi_driver_first_trans_fast(t68);
    goto LAB2;

LAB45:    t65 = 0;

LAB48:    if (t65 < 8U)
        goto LAB49;
    else
        goto LAB47;

LAB49:    t66 = (t62 + t65);
    t67 = (t61 + t65);
    if (*((unsigned char *)t66) != *((unsigned char *)t67))
        goto LAB46;

LAB50:    t65 = (t65 + 1);
    goto LAB48;

LAB51:    t80 = (t0 + 5712);
    t81 = (t80 + 56U);
    t82 = *((char **)t81);
    t83 = (t82 + 56U);
    t84 = *((char **)t83);
    *((unsigned char *)t84) = (unsigned char)6;
    xsi_driver_first_trans_fast(t80);
    goto LAB2;

LAB53:    t77 = 0;

LAB56:    if (t77 < 8U)
        goto LAB57;
    else
        goto LAB55;

LAB57:    t78 = (t74 + t77);
    t79 = (t73 + t77);
    if (*((unsigned char *)t78) != *((unsigned char *)t79))
        goto LAB54;

LAB58:    t77 = (t77 + 1);
    goto LAB56;

LAB60:    goto LAB2;

}

static void work_a_1184174073_3212880686_p_2(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t2 = (t0 + 2152U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 3112U);
    t3 = *((char **)t2);
    t2 = (t0 + 5840);
    t6 = (t2 + 56U);
    t9 = *((char **)t6);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3272U);
    t3 = *((char **)t2);
    t2 = (t0 + 3112U);
    t6 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB11;

LAB12:    t1 = 0;

LAB13:    if ((!(t1)) != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(83, ng0);
    t2 = (t0 + 5776);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB9:
LAB3:    t2 = (t0 + 5440);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 5776);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    xsi_set_current_line(81, ng0);
    t10 = (t0 + 5776);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)3;
    xsi_driver_first_trans_fast(t10);
    goto LAB9;

LAB11:    t13 = 0;

LAB14:    if (t13 < 8U)
        goto LAB15;
    else
        goto LAB13;

LAB15:    t2 = (t3 + t13);
    t9 = (t6 + t13);
    if (*((unsigned char *)t2) != *((unsigned char *)t9))
        goto LAB12;

LAB16:    t13 = (t13 + 1);
    goto LAB14;

}


void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_1184174073_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1184174073_3212880686_p_0,(void *)work_a_1184174073_3212880686_p_1,(void *)work_a_1184174073_3212880686_p_2};
	xsi_register_didat("work_a_1184174073_3212880686", "isim/Top_test_isim_beh.exe.sim/work/a_1184174073_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 5);
}
