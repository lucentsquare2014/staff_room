<%@ page language="java"
    contentType="text/html; charset=Windows-31J" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- �قƂ��html�����Ǖ����������������̂�jsp�� -->


<html>
<body>
	<h1>�A�������V�K�쐬</h1>

	<!-- ���̓t�H�[�� �f�[�^��newsWrite.jsp-->

	<form method="POST" action="newsWrite.jsp">
	<table border="1">
		<tr>
			<th>����</th>
				<td>
					<select name="inputPost">
					<option value="1">����</option>
					<option value="2">�l��</option>
					<option value="3">�s��</option>
					<option value="4">�J��</option>
					<option value="5">���̑�</option>
					</select>
				</td>
		</tr>
		<tr>
			<th>�^�C�g��</th>
				<td><input type="text" name="inputTitle" size="40"></td>
		</tr>
		<tr>
			<th>�{��</th>
				<td><textarea name="inputText" rows="10" cols="40"></textarea></td>
		</tr>

		<!-- �Y�t�t�@�C�� ��������ۗ�
		<tr>
			<th>�Y�t�t�@�C��</th>
				<td><input type="file" name="inputFile" size="30" /></td>
		</tr>
		-->

		<tr>
			<th>�ۑ���</th>
				<td><input type="text" name="inputWriter" size="40"></td>
		</tr>
	</table>
	<input type="submit" value="���e">
	<input type="reset" value="���ɖ߂�">
	</form>

<!-- /���̓t�H�[�� -->

</body>
</html>