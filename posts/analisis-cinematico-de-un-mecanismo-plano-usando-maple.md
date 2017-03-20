<!-- 
.. title: Análisis cinemático de un mecanismo plano usando Maple
.. slug: analisis-cinematico-de-un-mecanismo-plano-usando-maple
.. date: 2017-03-19 21:09:11 UTC-06:00
.. tags: mathjax,
.. category: 
.. link: 
.. description: 
.. type: text
-->



<p align="left"><table>
<tr>
<td valign="top" align="center"><font color="#78000e" size="3" face="Courier New"><strong>&gt; </strong></font></td>
<td valign="top"><img src="videos/abc_1.gif" width="49" height="13" alt="restart; -1" align="center" border="0"></td>
</tr>
</table>&nbsp;</p>
<p align="left"><table>
<tr>
<td valign="top" align="center"><font color="#78000e" size="3" face="Courier New"><strong>&gt; </strong></font></td>
<td valign="top"><img src="videos/abc_2.gif" width="221" height="16" alt="evalc(`+`(`*`(a, `*`(exp(`*`(I, `*`(theta(t)))))), `*`(b, `*`(exp(`*`(I, `*`(theta[2](t))))))))" align="center" border="0"></td>
</tr>
</table>&nbsp;</p>
<p align="center"><table width='100%'>
<tr>
<td valign="top" align="center"><font color="#0000ff" size="3" face="Times New Roman"><img src="videos/abc_3.gif" width="315" height="20" alt="`+`(`*`(a, `*`(cos(theta(t)))), `*`(b, `*`(cos(theta[2](t)))), `*`(I, `*`(`+`(`*`(a, `*`(sin(theta(t)))), `*`(b, `*`(sin(theta[2](t))))))))" align="center" border="0"></td>
<td width='5%' align='center'>(1)</td>
</tr>
</table></font>&nbsp;</p>
<p align="left"><table>
<tr>
<td valign="top" align="center"><font color="#78000e" size="3" face="Courier New"><strong>&gt; </strong></font></td>
<td valign="top"><img src="videos/abc_4.gif" width="87" height="13" alt="solve(`+`(`*`(a, `*`(cos(theta(t)))), `*`(b, `*`(cos(theta[2](t)))), `*`(I, `*`(`+`(`*`(a, `*`(sin(theta(t)))), `*`(b, `*`(sin(theta[2](t)))))))) = 0, a)" align="center" border="0"></td>
</tr>
</table>&nbsp;</p>
<p align="center"><table width='100%'>
<tr>
<td valign="top" align="center"><font color="#0000ff" size="3" face="Times New Roman"><img src="videos/abc_5.gif" width="175" height="38" alt="`+`(`-`(`/`(`*`(b, `*`(`+`(`*`(I, `*`(sin(theta[2](t)))), cos(theta[2](t))))), `*`(`+`(cos(theta(t)), `*`(I, `*`(sin(theta(t)))))))))" align="center" border="0"></td>
<td width='5%' align='center'>(2)</td>
</tr>
</table></font>&nbsp;</p>
<p align="left"><table>
<tr>
<td valign="top" align="center"><font color="#78000e" size="3" face="Courier New"><strong>&gt; </strong></font></td>
<td valign="top"></td>
</tr>
</table>&nbsp;</p>