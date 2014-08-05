## Apache Avro Dev Environment in Vagrant

Vagrant file and salt states to initialize build environment for apache avro project.

Apache avro has dependencies on thrift compiler and protobuf, that may be hard to configure/maintain.
Also these specific dependencies can conflict with dependencies that are installed locally on developer workstation.

So, now is the second time I have to recreate specific thrift compiler for avro project to recompile thrift schemas, and these scripts should make is as easy as:

```
$ vagrant up
$ vagrant ssh
$ cd /vagrant

```
This was already mentioned [here](https://issues.apache.org/jira/browse/AVRO-1500?focusedCommentId=14013503&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-14013503) as well as reasons why it is not part of avro project.

## SCM's and patching

So, after you have provisioned Vagrant VM, you can clone avro svn repositories to play around.

As of 2014-08-15 avro-project works with svn-patches model, so you have to submit svn-patches.
Sometimes it is easier to play around with svn (if you know it), than creating custom patches with git.

However, you can generate patches from git as well using:

```
git --no-pager diff --no-prefix
```

And then apply them using `patch` command:

```
patch -p0 < your-patch.patch
```
