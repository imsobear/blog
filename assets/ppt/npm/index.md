title: npm
speaker: 大果

[slide style="background-image:url('/imgs/bg.jpeg')"]

# 一个 npm 的完整历程

------

大果, 2015.7.2

[slide style="background-image:url('/imgs/bg2.png')"]

# 20 行的 npm

------

- [sindresorhus](https://github.com/sindresorhus) & [kevva](https://github.com/kevva): 

<small style="font-size:16px;text-indent:50px;">[wifi-name](https://github.com/kevva/wifi-name/blob/master/index.js) = osx-wifi-name + win-wifi-name + linux-wifi-name</small>
- 功能更加独立，可以把重复的事情做好
- 可以开心的刷 github ...
- 但是，真的有点奇葩

[slide style="background-image:url('/imgs/bg2.png')"]

# TDD: 测试驱动开发

--------

TDD 是极限编程中倡导的程序开发方法，倡导先写测试程序，然后编码实现其功能。即测试先行。

-------

```javascript
describe('test for getGitBranchName method', function() {

  it('should return a string(branch name) when the directory is a git repo', function(done) {

    // this repo directory path
    var dirPath = path.resolve(__dirname, '../');

    getGitBranchName(dirPath, function(err, branchName) {
      should.not.exist(err);
      (branchName).should.be.a.String;
      done();
    });

  });
});
```

[slide style="background-image:url('/imgs/bg2.png')"]

# nodejs 的单元测试

--------

- 测试框架：mocha
- 断言库：assert/chai/shouldjs
- 覆盖率：istanbul

<img src="/imgs/mocha.png" alt="" style="width:70%;top:200px;right:-200px;left:auto;min-width:0;min-height:0;">

[slide style="background-image:url('/imgs/bg2.png')"]

# 编码实现

- `/.git/HEAD`: 无法支持 submodule
- 解析 `git branch` 的输出

------

```javascript
module.exports = function(dirPath, callback) {

  var gitPath = path.resolve(dirPath, './.git');

  // parse `git branch` output
  execFile('git', ['--work-tree=' + dirPath, '--git-dir=' + gitPath, 'branch'], function(err, stdout, stderr) {

    if (err) {
      return callback(err);
    }

    try {
      var branchName = stdout === ''? '': stdout.match(/\*\s(.*)\n/)[1];
      callback(null, branchName);
    } catch(err) {
      callback(new Error('Parse the git branch stdout error'));
      console.error('output: %s', stdout);
    }
  });
};
```

[slide style="background-image:url('/imgs/bg2.png')"]

# 持续集成

----------

- 单元测试集成：[travis](https://travis-ci.org/imsobear/git-branch-name)
- 覆盖率集成：[coveralls](https://coveralls.io/r/imsobear/git-branch-name?branch=master)

<img src="/imgs/tt.png" alt="" style="width:70%;top:300px;right:-200px;left:auto;min-width:0;min-height:0;">

[slide style="background-image:url('/imgs/bg2.png')"]

# publish

-------

- npm 命名：`git-branch-name`, not `GitBranchName`
- npm 的版本号与 git tag 一致

------

```
git tag -a 1.0.0 -m '实现解析 git branch 输出'
git push origin 1.0.0

npm publish
```

[slide style="background-image:url('/imgs/bg2.png')"]

# One more thing

-------

- 遵循 semver 规范
- README

<img src="/imgs/readme.png" alt="" style="width:60%;top:50px;right:-100px;left:auto;min-width:0;min-height:0;max-height:1000px;">

<style>
    slides>slide .slide-wrapper {
        text-align: left !important;
    }
</style>