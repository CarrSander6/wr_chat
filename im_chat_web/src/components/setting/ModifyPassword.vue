<template>
    <div class="modify-password">
        <el-form :model="formData" label-width="80px" :rules="rules" ref="passwordForm" size="small">
            <el-form-item prop="oldPassword" label="原密码">
                <el-input v-model="formData.oldPassword" type="password" autocomplete="off" size="small"></el-input>
            </el-form-item>
            <el-form-item prop="newPassword" label="新密码">
                <el-input v-model="formData.newPassword" type="password" autocomplete="off" size="small"
                    maxlength="20"></el-input>
            </el-form-item>
            <el-form-item prop="confirmPassword" label="确认密码">
                <el-input v-model="formData.confirmPassword" type="password" autocomplete="off" size="small"></el-input>
            </el-form-item>
        </el-form>
        <div class="btn-group">
            <el-button type="primary" @click="onSubmit()">提 交</el-button>
        </div>
    </div>
</template>
<script>
export default {
    name: "modifyPassword",
    data() {
        var checkPassword = (rule, value, callback) => {
            if (value === '') {
                return callback(new Error('请输入密码'));
            }
            callback();
        };
        var checkConfirmPassword = (rule, value, callback) => {
            if (value === '') {
                return callback(new Error('请输入密码'));
            }
            if (value != this.formData.newPassword) {
                return callback(new Error('两次密码输入不一致'));
            }
            callback();
        };
        return {
            formData: {
                oldPassword: "",
                newPassword: "",
                confirmPassword: ""
            },
            rules: {
                newPassword: [{
                    validator: checkPassword,
                    trigger: 'blur'
                }],
                oldPassword: [{
                    validator: checkPassword,
                    trigger: 'blur'
                }],
                confirmPassword: [{
                    validator: checkConfirmPassword,
                    trigger: 'blur'
                }]
            },
        }
    },
    methods: {
        onSubmit() {
            this.$refs.passwordForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                this.$http({
                    url: "/modifyPwd",
                    method: "put",
                    data: this.formData
                }).then((res) => {
                    this.$message.success("修改成功");
                })
            });
        }
    }
}
</script>
<style scoped lang="scss">
.modify-password {
    padding: 10px 0 0 10px;

    .btn-group {
        text-align: center;
    }
}
</style>
